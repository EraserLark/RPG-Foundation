extends Node

var queue : Array[Event]
var currentEvent : Event
var parentState = null

signal queueEmpty

func _init(pState : State):
	parentState = pState

func finishEvent():
	pass

func emergencyExit():
	pass

func popQueue():
	if(!queue.is_empty()):
		currentEvent = queue.pop_front()
		currentEvent.runEvent()
	else:
		emit_signal("queueEmpty")
