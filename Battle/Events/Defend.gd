extends Action
class_name Defend

func _init(eManager, send, targ):
	super(eManager, send, targ)
	eventName = "Defend"

func runEvent():
	target.reactionComplete.connect(resumeEvent)
	target.gainStatus("Defend")
	#target = sender
	#target.boostDefense(1)

func resumeEvent():
	target.reactionComplete.disconnect(resumeEvent)
	finishEvent()