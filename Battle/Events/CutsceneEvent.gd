extends Event
class_name CutsceneEvent

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
