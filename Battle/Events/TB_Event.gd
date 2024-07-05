extends Event
class_name TB_Event

var message := ""
var tbState

func _init(eManager, tb, tbMessage):
	super(eManager) 
	tbState = Textbox_State.new(StateStack, tb, tbMessage)
	#battleUI = UI
	#message = tbMessage
	#
	#battleUI.textbox.boxFin.connect(finishEvent)
	#battleUI.textboxNewMessage(message)

func runEvent():
	StateStack.addState(tbState)

func resumeEvent():
	finishEvent()
