extends State
class_name DB_State

var dialogueBox = null

func _init(sStack, db):
	super(sStack)
	dialogueBox = db

func enter(msg := {}):
	super()
	dialogueBox.newDialogue()

func update(delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		if dialogueBox.finished == false:
			dialogueBox.skip = true
			dialogueBox.typeTimer.stop()
			dialogueBox.typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
		else:
			exit()

func exit():
	dialogueBox.closeBox()
	super()
