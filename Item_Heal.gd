extends Item
class_name Item_Heal

func _init():
	itemAction = HealAction.new(null, null, null)

class HealAction:
	extends Action
	func _init(eManager, send, targ):
		super(eManager, send, targ)
		eventName = "Mushroom"
	func runEvent():
		target = sender
		target.reactionComplete.connect(resumeEvent)
		target.gainHealth(5)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
