extends Entity
class_name OWEntity_Player

var playerStateStack = StateStack.new()
var overworldManager: OverworldManager
var dialogueManager:= DialogueManager.new(self)

var entityActor: OW_Player
var entityUI: PlayerUI_World #Not sure OW equivalent for entityUI
var rosterNumber: int
var playerActiveState: Player_Active #Store to assign new actors between rooms

##INPUT
var deviceNumber:= -99	#Set this so throws error if no controller num passed
var input: DeviceInput

func _ready():
	self.add_child(playerStateStack)	#Add so _process() gets called
	input = DeviceInput.new(deviceNumber)
	playerStateStack.playerNumber

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	if(om == null):
		printerr("overworldManager not passed")
		return
	overworldManager = om
	if(entityActor == null):
		entityActor = overworldManager.overworldWorld.currentRoom.castList.playerActors[rosterNumber]
	entityUI = overworldManager.overworldUI.playerUIRoster[rosterNumber]
	
	var connectionState = GameState_Connection.new(playerStateStack, GameStateStack.foundationGameState)
	playerStateStack.addState(connectionState)	#Enters game state roundabout

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
	if entityActor != null:
		entityActor.queue_free()
	entityUI.queue_free()
	
