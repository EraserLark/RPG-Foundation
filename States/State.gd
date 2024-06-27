#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends Node
class_name State

var stateMachine = null

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	#StateMachineStack.addSM(stateMachine)
	pass

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	pass
