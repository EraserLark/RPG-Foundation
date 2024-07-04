#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends Node
class_name State

var stateStack = null

func _init(sStack : StateStack):
	stateStack = sStack

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	pass

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func resumeState():
	pass

func exit():
	stateStack.removeState()
