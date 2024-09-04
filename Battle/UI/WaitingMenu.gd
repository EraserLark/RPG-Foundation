extends ManualMenu
class_name WaitingMenu

func _ready():
	firstFocus = null

func OpenMenu():
	super()
	menuManager.isFinished = true

func activateOption():
	pass

func rejectMenu():
	menuManager.isFinished = false
	super()
