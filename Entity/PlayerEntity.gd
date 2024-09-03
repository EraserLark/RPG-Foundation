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
#BattleEntity_Player
##Outside references
#var playerBattleUI: PlayerUI_Battle
var playerBattlePanel: PlayerPanel_Battle

##Inside vars
#var playerActor: BattleActor_Player

##Signals
signal playerDied

#BattleEntity
#var battleEntityActor: BattleActor
var battleUI: EntityUI

##Outside references
var battleManager: BattleManager
var battleActor: BattleActor

##Inside references
var statusEffects: Array[StatusEffect]
var isDead:= false


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
		worldUI = overworldManager.overworldUI.playerUIRoster[rosterNumber]
		
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
	pass

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
