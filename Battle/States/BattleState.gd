extends State
class_name Battle_State

var battleEQ = EventQueue.new()
var battleManager

enum battlePhases {START, PROMPT, ACTION, FINISH}
var currentPhase: battlePhases

func _init(sStack: StateStack, bm):
	stateStack = sStack
	battleManager = bm
	
	var startingEvent = Start_Phase.new(battleEQ, battleManager)
	battleEQ.addEvent(startingEvent)
	
	battleEQ.queueEmpty.connect(exit)

func handleInput(_event: InputEvent):
	pass

func enter(_msg:= {}):
	battleEQ.popQueue()

func resumeState():
	if(battleEQ.queue.is_empty() && battleEQ.currentEvent == null):
		exit()
	else:
		battleEQ.currentEvent.resumeEvent()

func exit():
	set_process_input(false)
	battleEQ.queueEmpty.disconnect(exit)
	super()
	battleManager.queue_free()
