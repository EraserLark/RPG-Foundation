extends Node
##Game State Stack Autoload

var gameStateStack: StateStack

func _init():
	var baseState = State.new(gameStateStack)
	addState(baseState)

func addState(s: State, _msg:={}):
	gameStateStack.stateStack.push_front(s)
	gameStateStack.currentState = gameStateStack.stateStack.front()
	gameStateStack.currentState.stateStack = gameStateStack
	for state in gameStateStack.stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	gameStateStack.currentState.enter(_msg)

func resumeCurrentState():
	gameStateStack.currentState.resumeState()

func removeState():
	gameStateStack.stateStack.pop_front()
	
	if(gameStateStack.stateStack.is_empty()):
		print("STACK EMPTY")
	gameStateStack.currentState = gameStateStack.stateStack.front()
	for state in gameStateStack.stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	resumeCurrentState()

#func _unhandled_input(event):
	#gameStateStack.currentState.handleInput(event)
#
#func _process(delta):
	#gameStateStack.currentState.update(delta)
#
#func _physics_process(delta):
	#gameStateStack.currentState.physicsUpdate(delta)
