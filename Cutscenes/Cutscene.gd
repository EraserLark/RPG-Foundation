extends State
class_name Cutscene_State

var cutsceneManager : CutsceneManager
var cutsceneEQ: EventQueue
var battleManager: BattleManager

func _init(sStack, cm, bm):
	super(sStack)
	cutsceneEQ = EventQueue.new(sStack)
	cutsceneManager = cm
	battleManager = bm
	
	cutsceneManager.currentCutscene = self

func animFin():
	cutsceneEQ.currentEvent.resumeEvent()

func exit():
	super()

func resumeState():
	if(cutsceneEQ.queue.is_empty() && cutsceneEQ.currentEvent == null):
		exit()
	else:
		cutsceneEQ.currentEvent.resumeEvent()

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
		var cutscene = cutsceneClass.new(GameStateStack.stack, battleManager.cutsceneManager, battleManager)
		GameStateStack.stack.addState(cutscene)
	
	func resumeEvent():
		finishEvent()
