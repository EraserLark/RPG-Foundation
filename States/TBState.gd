extends State
class_name Textbox_State

var textbox: Textbox
var ui: Control
var message: Array[String]

func _init(sStack, m, userintf):
	super(sStack)
	message = m
	ui = userintf

func enter(_msg := {}):
	textbox = Textbox.createInstance(ui, message)
	textbox.advanceLineQueue()

func update(_delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		textbox.advance()

func resumeState():
	if(textbox.tbFinished):
		exit()

func exit():
	textbox.closeTextbox()
	super()

static func createEvent(eManager:EventQueue, ss:StateStack, m:Array[String], userintf: Control):
	var tbEvent = EventClass.new(eManager, ss, m, userintf)
	eManager.addEvent(tbEvent)

class EventClass:
	extends Event
	
	var ui
	var stateStack
	var message

	func _init(eManager, ss, m, userintf):
		super(eManager)
		stateStack = ss
		message = m
		ui = userintf

	func runEvent():
		var tbState = Textbox_State.new(StateStack, message, ui)
		StateStack.addState(tbState)

	func resumeEvent():
		finishEvent()

	func finishEvent():
		eventManager.popQueue()
