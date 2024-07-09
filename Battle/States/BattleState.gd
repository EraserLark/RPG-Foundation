extends State
class_name Battle_State

var eventQueue = EventQueue.new()
var battleManager

enum battlePhases {START, PROMPT, ACTION, FINISH}
var currentPhase : battlePhases

func _init(sStack : StateStack, bm):
	stateStack = sStack
	battleManager = bm
	var startingEvent = Start_Phase.new(eventQueue, battleManager)
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
