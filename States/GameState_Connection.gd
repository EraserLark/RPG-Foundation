extends State
class_name GameState_Connection

var gameState: GameState

func _init(sStack: StateStack, gs: GameState):
	stateStack = sStack
	gameState = gs

func handleInput(_event: InputEvent):
	if _event.device == stateStack.deviceNumber:
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
