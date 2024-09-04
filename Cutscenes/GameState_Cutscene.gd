extends GameState
class_name GameState_Cutscene

var cutsceneManager: CutsceneManager
var cutsceneEQ: EventQueue
var stageManager: StageManager

func _init(cm: CutsceneManager, sm: StageManager):
	cutsceneEQ = EventQueue.new()
	cutsceneManager = cm
	stageManager = sm
	
	cutsceneManager.currentCutscene = self

func animFin():
	cutsceneEQ.currentEvent.resumeEvent()

func stackResume():
	if(cutsceneEQ.queue.is_empty() && cutsceneEQ.currentEvent == null):
		stackExit()
	else:
		cutsceneEQ.currentEvent.resumeEvent()

func stackExit():
	super()

static func createEvent(eManager, bm, cc):
	var cutsceneEvent = EventClass.new(eManager, bm, cc)
	eManager.addEvent(cutsceneEvent)

class EventClass:
	#class_name CutsceneEvent
	extends Event
	
	var stageManager
	var cutsceneClass
	
	func _init(eManager, sm, cc):
		super(eManager)
		stageManager = sm
		cutsceneClass = cc
	
	func runEvent():
		var cutscene = cutsceneClass.new(stageManager.cutsceneManager, stageManager)
		GameStateStack.stack.addState(cutscene)
	
	func resumeEvent():
		finishEvent()
