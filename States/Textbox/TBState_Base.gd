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
	textbox = Textbox.createInstance(container, message, self)
	textbox.ownerState = self
	textbox.advanceLineQueue()

#func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
		#textbox.advance()

func handleInput(_event: InputEvent):
	if _event.device == PlayerRoster.roster[stateStack.playerNumber].deviceNumber:
		if _event.is_action_pressed("ui_accept"):
			textbox.confirmInput()

func resumeState():
	if(textbox.finished):
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
		var tbState = Textbox_State.new(stateStack, message, container)
		stateStack.addState(tbState)

	func resumeEvent():
		finishEvent()

	func finishEvent():
		eventManager.popQueue()
