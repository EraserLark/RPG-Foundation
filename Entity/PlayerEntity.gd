extends Entity
class_name PlayerEntity

var playerStateStack := StateStack.new()
var dialogueManager:= DialogueManager.new(self)
var rosterNumber: int
enum STAGE {WORLD, BATTLE}
var currentStage: STAGE = STAGE.WORLD

##INPUT
var deviceNumber:= -99	#Set this so throws error if no controller num passed
var input: DeviceInput

##OVERWORLD
var overworldManager: OverworldManager
var worldActor: OW_Player
var worldUI: PlayerUI_World
var playerActiveState: Player_Active #Store to assign new actors between rooms

##BATTLE
var battleManager: BattleManager
#var playerBattlePanel: PlayerPanel_Battle	#Unecessary?
var battleUI: PlayerUI_Battle
var battleActor: BattleActor

var statusEffects: Array[StatusEffect]
var isDead:= false

##Signals
signal playerDied


func _ready():
	if currentStage == STAGE.WORLD:
		self.add_child(playerStateStack)	#Add so _process() gets called
		input = DeviceInput.new(deviceNumber)
		playerStateStack.playerNumber
	elif currentStage == STAGE.BATTLE:
		pass

func initialize(sm: StageManager = null):
	if sm is OverworldManager:
		if(sm == null):
			printerr("overworldManager not passed")
			return
		overworldManager = sm
		if(worldActor == null):
			worldActor = overworldManager.overworldWorld.currentRoom.castList.playerActors[rosterNumber]
		worldUI = overworldManager.stageUI.playerUIRoster[rosterNumber]
		
		#var connectionState = GameState_Connection.new(playerStateStack, GameStateStack.foundationGameState)
		#playerStateStack.addState(connectionState)	#Enters game state roundabout
		GameStateStack.CatchUpOnStates(playerStateStack)
	elif sm is BattleManager:
		if(sm == null):
			printerr("battleManager not passed")
			return
		battleManager = sm
		if(battleActor == null):
			battleActor = battleManager.battleStage.playerActors[rosterNumber]
		battleUI = battleManager.stageUI.playerUIRoster[rosterNumber]
		
		var connectionState = GameState_Connection.new(playerStateStack, GameStateStack.foundationGameState)
		playerStateStack.addState(connectionState)	#Enters game state roundabout


func getClassInstance():
	return self

#Only built for battle rn
func gainStatus(statusType):
	if(statusType == Status.Type.POISON):
		applyStatus(PoisonStatus, battleManager.actionPhase.statusRoster)
	elif(statusType == Status.Type.DEFUP):
		applyStatus(DefenseStatus, battleManager.actionPhase.statusRoster)
	emit_signal("reactionComplete")

#Only built for battle rn
func applyStatus(statusEffect, statusRoster):
	var newStatus = statusEffect.new(battleManager, self, statusRoster)
	statusEffects.append(newStatus)
	statusRoster.append(newStatus)
	
	battleManager.actionPhase.unresolvedStatuses.append(newStatus)

func boostDefense(amt: int):
	super(amt)

func decreaseDefense(amt: int):
	super(amt)

func revertStatus():
	super()

func gainHealth(amt: int):
	entityInfo.addHealth(amt)
	
	if currentStage == STAGE.BATTLE:
		battleActor.healFeedback()

func fullHeal():
	var maxHP = entityInfo.hpMax
	var currentHP = entityInfo.hp
	entityInfo.addHealth(maxHP - currentHP)

func takeDamage(dmg: int, pierce: bool):
	if currentStage == STAGE.BATTLE:
		var trueDmg = dmg
	
		if(!pierce):
			trueDmg = entityInfo.calcDamage(dmg)
		
		entityInfo.takeDamage(trueDmg)
		battleActor.damageFeedback(trueDmg)
		
		var remainingHealth = entityInfo.hp
		#updateUI(remainingHealth)
		
		if(remainingHealth <= 0):
			var deathEvent = Death_Event.new(playerStateStack, battleManager.actionPhase.actionEQ, self, battleManager)
			battleManager.actionPhase.actionEQ.queue.push_front(deathEvent)


func attackChosen(attackNum: int):
	entityInfo.selectedAction = entityInfo.attackList[attackNum]
	return entityInfo.selectedAction

func actionChosen(actionNum: int):
	entityInfo.selectedAction = entityInfo.miscList[actionNum]
	return entityInfo.selectedAction

func itemChosen(itemNum: int):
	var item = entityInfo.itemList[itemNum]
	entityInfo.selectedAction = item.itemAction
	return entityInfo.selectedAction

func itemDiscarded(itemNum: int):
	entityInfo.itemList = Helper.removeIndex(entityInfo.itemList, itemNum)

func entityDead():
	isDead = true
	eraseSelectedAction()
	for effect in statusEffects:
		effect.endStatus()
	playerStateStack.removeGameState()	#Removes Action Game State

func eraseSelectedAction():
	battleManager.actionPhase.actionEQ.queue.erase(entityInfo.selectedAction)

func checkRoster():
	var result = battleManager.checkPlayersAlive()
	return result

func endEntity():
	if currentStage == STAGE.WORLD:
		if worldActor != null:
			worldActor.queue_free()
		worldUI.queue_free()
	elif currentStage == STAGE.BATTLE:
		pass

func enterBattleStage():
	currentStage = STAGE.BATTLE
	#entityInfo.entityUI = battleUI

func exitBattleStage():
	currentStage = STAGE.WORLD
	entityInfo.entityUI = worldUI
	
	if entityInfo.hp <= 0:
		gainHealth(1)
