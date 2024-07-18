extends State
class_name Cutscene_State

var cutsceneManager : CutsceneManager
var cutsceneEQ = EventQueue.new()
var battleManager

func _init(sStack, cm, bm):
	super(sStack)
	cutsceneManager = cm
	battleManager = bm
	
	cutsceneManager.currentCutscene = self
	cutsceneEQ.queueEmpty.connect(exit)

func animFin():
	cutsceneEQ.currentEvent.resumeEvent()

func exit():
	cutsceneEQ.queueEmpty.disconnect(exit)
	super()

func resumeState():
	if(cutsceneEQ.queue.is_empty() && cutsceneEQ.currentEvent == null):
		exit()
	else:
		cutsceneEQ.currentEvent.resumeEvent()
	#elif(cutsceneEQ.queue.front() == cutsceneEQ.currentEvent):
		#exit()

static func createEvent(eManager, bm, cc):
	var cutsceneEvent = EventClass.new(eManager, bm, cc)
	eManager.addEvent(cutsceneEvent)

class EventClass:
	#class_name CutsceneEvent
	extends Event
	
	var battleManager
	var cutsceneClass
	
	func _init(eManager, bm, cc):
		super(eManager)
		battleManager = bm
		cutsceneClass = cc
	
	func runEvent():
		var cutscene = cutsceneClass.new(StateStack, battleManager.cutsceneManager, battleManager)
		StateStack.addState(cutscene)
	
	func resumeEvent():
		finishEvent()
