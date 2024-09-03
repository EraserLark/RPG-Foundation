extends Node
class_name EventQueue

var stateStack: StateStack
var queue : Array[Event]
var currentEvent : Event

func _init(sStack: StateStack = null):
	stateStack = sStack

func addEvent(e: Event):
	queue.append(e)

func finishEvent():
	pass

func emergencyExit():
	pass

func popQueue():
	if(!queue.is_empty()):
		currentEvent = queue.pop_front()
		currentEvent.runEvent()
	else:
		currentEvent = null
		if stateStack != null:
			stateStack.resumeCurrentState()
		else:
			GameStateStack.resumeCurrentState()
