#https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
extends Node
class_name State

var stateStack = null

var interrupted := false
var interruptorClass

func _init(sStack: StateStack):
	stateStack = sStack

func handleInput(_event: InputEvent):
	pass

func enter(_msg:= {}):
	pass

func update(_delta: float):
	pass

func physicsUpdate(_delta: float):
	pass

func interruptState(interruptor):
	interrupted = true
	interruptorClass = interruptor

func resumeState():
	pass

func exit():
	stateStack.removeState()

class EventClass:
	pass
