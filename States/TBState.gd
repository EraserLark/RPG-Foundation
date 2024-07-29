extends State
class_name Textbox_State

var textbox
var ui
var message

func _init(sStack, m, userintf):
	super(sStack)
	message = m
	ui = userintf

func enter(_msg := {}):
	textbox = Textbox.createInstance(ui, message, Vector2.ZERO, Vector2(300,100))

func update(_delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		textbox.advance()

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
