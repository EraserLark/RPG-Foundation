extends Node

var stateMachineStack : Array[StateMachine]
var currentStateMachine : StateMachine = null

func _ready():
	pass

func addSM(sm : StateMachine):
	stateMachineStack.push_front(sm)
	currentStateMachine = stateMachineStack.front()
	currentStateMachine.sm_enter()
	print(stateMachineStack)

func removeSM():
	stateMachineStack.pop_front()
	currentStateMachine = stateMachineStack.front()
	print(stateMachineStack)

func _unhandled_input(event):
	currentStateMachine.sm_handleInput(event)

func _process(delta):
	currentStateMachine.sm_update(delta)

func _physics_process(delta):
	currentStateMachine.sm_physicsUpdate(delta)
