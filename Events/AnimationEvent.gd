extends Event
class_name AnimationEvent

var animPlayer : AnimationPlayer
var animName : String

func _init(eManager, ap, an):
	super(eManager)
	animPlayer = ap
	animName = an

func runEvent():
	animPlayer.animation_finished.connect(animFinished)
	animPlayer.play(animName)

func animFinished(animName):
	finishEvent()

func finishEvent():
	animPlayer.animation_finished.disconnect(animFinished)
	eventManager.popQueue()
