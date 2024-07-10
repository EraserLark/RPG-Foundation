extends Event
class_name TB_Event

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
