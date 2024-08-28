extends Node
class_name Event

var eventName: String
var eventManager: EventQueue = null

signal eventFinished

func _init(eManager: EventQueue):
	eventManager = eManager

func runEvent():
	pass

func resumeEvent():
	pass

func finishEvent():
	eventManager.popQueue()
