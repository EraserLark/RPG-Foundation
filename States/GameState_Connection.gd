extends State
class_name GameState_Connection

var gameState: GameState
var deviceNumber: int

func _init(sStack: StateStack, gs: GameState):
	stateStack = sStack
	gameState = gs
	
	deviceNumber = PlayerRoster.roster[stateStack.playerNumber].deviceNumber

func handleInput(_event: InputEvent):
	if _event.device == deviceNumber:
		gameState.handleInput(stateStack.playerNumber, _event)

func enter(_msg:= {}):
	gameState.enter(stateStack.playerNumber, _msg)

func update(_delta: float):
	gameState.update(stateStack.playerNumber, _delta)

func physicsUpdate(_delta: float):
	gameState.physicsUpdate(stateStack.playerNumber, _delta)

func resumeState():
	gameState.resumeState(stateStack.playerNumber)

func exit():
	gameState.exit(stateStack.playerNumber)

class EventClass:
	pass
