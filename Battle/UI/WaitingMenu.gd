extends ManualMenu
class_name WaitingMenu

signal playerSubmitted

func _ready():
	firstFocus = null

func OpenMenu():
	super()
	menuManager.isFinished = true
	emit_signal("playerSubmitted")

func activateOption():
	pass

func rejectMenu():
	menuManager.isFinished = false
	super()
