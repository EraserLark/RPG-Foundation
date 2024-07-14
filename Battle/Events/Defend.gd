extends Action
class_name Defend

func _init(eManager, send, targ, targOpts):
	super(eManager, send, targ, targOpts)
	eventName = "Defend"

func runEvent():
	target.reactionComplete.connect(resumeEvent)
	target.gainStatus("Defend")
	#target = sender
	#target.boostDefense(1)

func resumeEvent():
	target.reactionComplete.disconnect(resumeEvent)
	finishEvent()
