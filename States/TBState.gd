extends State
class_name Textbox_State

var textbox: Textbox
var container: Control
var message: Array[String]

func _init(sStack, m, cntnr):
	super(sStack)
	message = m
	container = cntnr

func enter(_msg := {}):
	textbox = Textbox.createInstance(container, message)
	textbox.advanceLineQueue()

func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
		#textbox.advance()
		pass

func resumeState():
	if(textbox.tbFinished):
		exit()

func exit():
	textbox.closeTextbox()
	super()

static func createEvent(eManager:EventQueue, ss:StateStack, m:Array[String], cntnr: Control):
	var tbEvent = EventClass.new(eManager, ss, m, cntnr)
	eManager.addEvent(tbEvent)

class EventClass:
	extends Event
	
	var container
	var stateStack
	var message

	func _init(eManager, ss, m, cntnr):
		super(eManager)
		stateStack = ss
		message = m
		container = cntnr

	func runEvent():
		var tbState = Textbox_State.new(StateStack, message, container)
		StateStack.addState(tbState)

	func resumeEvent():
		finishEvent()

	func finishEvent():
		eventManager.popQueue()
