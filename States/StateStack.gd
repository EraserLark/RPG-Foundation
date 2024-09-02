extends Node
class_name StateStack

var stateStack: Array[State]
var currentState: State = null

func _init():
	var baseState = State.new(self)
	addState(baseState)

func addState(s: State, _msg:={}):
	stateStack.push_front(s)
	currentState = stateStack.front()
	currentState.stateStack = self
	for state in stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	currentState.enter(_msg)

func resumeCurrentState():
	currentState.resumeState()

func removeState():
	stateStack.pop_front()
	
	if(stateStack.is_empty()):
		print("STACK EMPTY")
	currentState = stateStack.front()
	for state in stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	resumeCurrentState()

func removeGameState():
	#Iterate through stack until finds first Game State.
	var popState = stateStack.pop_front()
	if popState is GameState:
	#Pop Game State.
		return
	else:
	#Pop each state found along the way.
		removeGameState()

func _unhandled_input(event):
	currentState.handleInput(event)

func _process(delta):
	currentState.update(delta)

func _physics_process(delta):
	currentState.physicsUpdate(delta)
