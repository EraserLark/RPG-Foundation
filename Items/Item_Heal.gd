extends Item
class_name Item_Heal

func _init():
	super("Health Pack")
	itemAction = HealAction.new(null, null, null, Action.TargetTypes.PLAYER, null)

class HealAction:
	extends Action
	func _init(eManager, send, targ, targType, stgmn: StageManager):
		super(eManager, send, targ, targType, stgmn)
		eventName = "Health Pack"
	func runEvent():
		target = sender
		target.reactionComplete.connect(resumeEvent)
		target.gainHealth(5)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
