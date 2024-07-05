extends State
class_name Battle_State

var battleUI
var eventQueue = EventQueue.new()

func _init(sStack : StateStack, UI):
	stateStack = sStack
	var startingEvent = Start_Phase.new(eventQueue, UI)
	eventQueue.addEvent(startingEvent)

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	eventQueue.popQueue()

func resumeState():
	if(eventQueue.queue.front() == eventQueue.currentEvent):
		exit()
	else:
		eventQueue.currentEvent.resumeEvent()

func exit():
	stateStack.removeState()
