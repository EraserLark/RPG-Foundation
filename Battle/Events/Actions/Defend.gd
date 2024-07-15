extends Action
class_name Defend

func _init(eManager, send, targ, targType, bm):
	super(eManager, send, targ, targType, bm)
	eventName = "Defend"
	targetType = TargetTypes.PLAYER

func runEvent():
	target.reactionComplete.connect(resumeEvent)
	target.gainStatus(Status.Type.DEFUP)

func resumeEvent():
	target.reactionComplete.disconnect(resumeEvent)
	finishEvent()
