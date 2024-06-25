#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/=
extends Node
class_name StateMachine

@onready var state : State = get_node(initialState)

@export var initialState := NodePath()

signal tranisitoned(stateName)

func _ready():
	for child in get_children():
		child.state_machine = self
	state.enter()

func _unhandled_input(event):
	state.handleInput(event)

func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.physicsUpdate(delta)

func transition_to(target_state_name : String, msg: Dictionary = {}):
	if not has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
