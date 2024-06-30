#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/=
extends Node
class_name StateMachine

@onready var state : State = get_node(initialState)
@onready var manager = StateMachineStack

@export var initialState := NodePath()

signal tranisitoned(stateName)

func _ready():
	for child in get_children():
		child.stateMachine = self

func sm_enter():
	state.enter()

func sm_handleInput(event):
	state.handleInput(event)

func sm_update(delta):
	state.update(delta)

func sm_physicsUpdate(delta):
	state.physicsUpdate(delta)

func transition_to(target_state_name : String, msg: Dictionary = {}):
	if not has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("tranisitoned", state.name)

func endStateMachine():
	StateMachineStack.removeSM()
