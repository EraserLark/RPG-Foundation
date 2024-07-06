extends State
class_name Battle_State

var battleUI
var enemy
var player

var eventQueue = EventQueue.new()

func _init(sStack : StateStack, e, p, ui):
	stateStack = sStack
	enemy = e
	player = p
	battleUI = ui
	var startingEvent = Start_Phase.new(eventQueue, enemy, player, battleUI)
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
