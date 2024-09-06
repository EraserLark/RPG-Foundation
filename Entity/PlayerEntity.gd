extends Entity
class_name PlayerEntity

var playerStateStack = StateStack.new()
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

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	if currentStage == STAGE.WORLD:
		if(om == null):
			printerr("overworldManager not passed")
			return
		overworldManager = om
		if(worldActor == null):
			worldActor = overworldManager.overworldWorld.currentRoom.castList.playerActors[rosterNumber]
		worldUI = overworldManager.stageUI.playerUIRoster[rosterNumber]
		
		var connectionState = GameState_Connection.new(playerStateStack, GameStateStack.foundationGameState)
		playerStateStack.addState(connectionState)	#Enters game state roundabout
	elif currentStage == STAGE.BATTLE:
		pass

func getClassInstance():
	return self

func gainStatus(statusType):
	pass

func applyStatus(statusEffect, statusRoster):
	pass

func boostDefense(amt: int):
	super(amt)

func decreaseDefense(amt: int):
	super(amt)

func revertStatus():
	super()

func gainHealth(amt: int):
	entityInfo.addHealth(amt)

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

func checkRoster():
	pass

func entityDead():
	pass

func endEntity():
	if currentStage == STAGE.WORLD:
		if worldActor != null:
			worldActor.queue_free()
		worldUI.queue_free()
	elif currentStage == STAGE.BATTLE:
		pass

func enterBattleStage():
	currentStage = STAGE.BATTLE

func exitBattleStage():
	currentStage = STAGE.WORLD
