extends State
class_name Textbox_State

var textbox
var message

func _init(sStack, tb, m):
	super(sStack)
	textbox = tb
	message = m

func enter(_msg := {}):
	super()
	textbox.line = message
	textbox.openBox()
	textbox.typeText()

func update(_delta : float):
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

static func createEvent(eManager:EventQueue, ss:StateStack, tb:Textbox, m:String):
	var tbEvent = EventClass.new(eManager, ss, tb, m)
	eManager.addEvent(tbEvent)

class EventClass:
	extends Event

	var stateStack
	var textbox
	var message

	func _init(eManager, ss, tb, m):
		super(eManager)
		stateStack = ss
		textbox = tb
		message = m

	func runEvent():
		var tbState = Textbox_State.new(StateStack, textbox, message)
		StateStack.addState(tbState)

	func resumeEvent():
		finishEvent()

	func finishEvent():
		eventManager.popQueue()
