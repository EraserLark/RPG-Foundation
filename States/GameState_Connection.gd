extends State
class_name GameState_Connection

var gameState: GameState
#var deviceNumber: int

func _init(sStack: StateStack, gs: GameState):
	stateStack = sStack
	gameState = gs
	
	#deviceNumber = PlayerRoster.roster[stateStack.playerEntity.rosterNumber].deviceNumber

func handleInput(_event: InputEvent):
	#if _event.device == deviceNumber:
	gameState.handleInput(stateStack.playerEntity.rosterNumber, _event)

func enter(_msg:= {}):
	gameState.enter(stateStack.playerEntity.rosterNumber, _msg)

func update(_delta: float):
	gameState.update(stateStack.playerEntity.rosterNumber, _delta)

func physicsUpdate(_delta: float):
	gameState.physicsUpdate(stateStack.playerEntity.rosterNumber, _delta)

func interruptState(interruptor):
	pass

func resumeState():
	gameState.resumeState(stateStack.playerEntity.rosterNumber)

func exit():
	gameState.exit(stateStack.playerEntity.rosterNumber)

class EventClass:
	pass
