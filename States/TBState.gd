extends State
class_name Textbox_State

var textbox
var message

func _init(sStack, tb, m):
	super(sStack)
	textbox = tb
	message = m

func enter(msg := {}):
	super()
	textbox.line = message
	textbox.openBox()
	textbox.typeText()

func update(delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		if textbox.finished == false:
			textbox.skip = true
			textbox.typeTimer.stop()
			textbox.typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
		else:
			exit()

func exit():
	textbox.closeBox()
	super()
