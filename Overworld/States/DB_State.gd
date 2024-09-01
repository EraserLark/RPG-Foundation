extends State
class_name DialogueBox_State

var dialogueBox: DialogueBox
var parent: Control
var message: Array[String]
var speaker: String

func _init(sStack, m, sp, p):
	super(sStack)
	message = m
	speaker = sp
	parent = p

func enter(_msg := {}):
	dialogueBox = DialogueBox.createDBInstance(parent, message, speaker, self)
	dialogueBox.advanceLineQueue()

func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
		#dialogueBox.advance()
		pass

func resumeState():
	if(dialogueBox.tbFinished):
		exit()

func exit():
	dialogueBox.closeTextbox()
	parent.queue_free()
	super()

static func createEvent(eManager:EventQueue, ss:StateStack, m:Array[String], sp:String, p: Control):
	var dbEvent = EventClass.new(eManager, ss, m, sp, p)
	eManager.addEvent(dbEvent)

class EventClass:
	extends Event
	
	var parent
	var stateStack
	var message
	var speaker

	func _init(eManager, ss, m, sp, p):
		super(eManager)
		stateStack = ss
		message = m
		speaker = sp
		parent = p

	func runEvent():
		var dbState = DialogueBox_State.new(stateStack, message, speaker, parent)
		stateStack.addState(dbState)

	func resumeEvent():
		finishEvent()

	func finishEvent():
		eventManager.popQueue()
