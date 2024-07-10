extends State
class_name Cutscene_State

var cutsceneManager : CutsceneManager
var eventQueue = EventQueue.new()
var battleManager

func _init(sStack, cm, bm):
	super(sStack)
	cutsceneManager = cm
	battleManager = bm
	
	cutsceneManager.currentCutscene = self

func animFin():
	eventQueue.currentEvent.resumeEvent() 

func resumeState():
	if(eventQueue.queue.front() == eventQueue.currentEvent):
		exit()
	elif(eventQueue.queue.is_empty()):
		exit()
	else:
		eventQueue.currentEvent.resumeEvent()
