extends Node
class_name EventQueue

var queue : Array[Event]
var currentEvent : Event
var startState = null

signal queueEmpty

func _init():
	pass
	#startState = sState

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
		#currentEvent.resumeEvent()
		emit_signal("queueEmpty")
