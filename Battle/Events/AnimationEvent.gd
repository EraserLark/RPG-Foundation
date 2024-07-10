extends Event
class_name AnimationEvent

var cutsceneManager : CutsceneManager
var animName : String

func _init(eManager, cm, an):
	super(eManager)
	cutsceneManager = cm
	animName = an

func runEvent():
	cutsceneManager.play(animName)

func resumeEvent():
	finishEvent()

func finishEvent():
	eventManager.popQueue()
