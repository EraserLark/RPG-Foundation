extends Event
class_name AnimationEvent

var animPlayer : AnimationPlayer
var animName : String

func _init(eManager, ap, an):
	super(eManager)
	animPlayer = ap
	animName = an

func runEvent():
	animPlayer.animation_finished.connect(resumeEvent)
	animPlayer.play(animName)

func resumeEvent():
	finishEvent()

func finishEvent():
	animPlayer.animation_finished.disconnect(resumeEvent)
	eventManager.popQueue()
