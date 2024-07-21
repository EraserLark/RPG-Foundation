extends Node
class_name EventQueue

var queue : Array[Event]
var currentEvent : Event

func _init():
	pass

func addEvent(e : Event):
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
		StateStack.resumeCurrentState()
