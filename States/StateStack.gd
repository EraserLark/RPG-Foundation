extends Node

var stateStack: Array[State]
var currentState: State = null

func _ready():
	pass

func addState(s: State):
	stateStack.push_front(s)
	currentState = stateStack.front()
	currentState.stateStack = self
	for state in stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	currentState.enter()

func removeState():
	stateStack.pop_front()
	
	if(stateStack.is_empty()):
		print("STACK EMPTY")
	currentState = stateStack.front()
	for state in stateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	currentState.resumeState()

func _unhandled_input(event):
	currentState.handleInput(event)

func _process(delta):
	currentState.update(delta)

func _physics_process(delta):
	currentState.physicsUpdate(delta)
