extends Event
class_name OpenBattleEvent

var currentRoom: Room

func _init(eManager: EventQueue, rm: Room):
	super(eManager)
	currentRoom = rm

func runEvent():
	currentRoom.startBattle()

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
