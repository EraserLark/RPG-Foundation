extends Item
class_name Item_Heal

func _init(bm : BattleManager):
	super(bm, "Mushroom")
	itemAction = HealAction.new(null, null, null, Action.TargetTypes.PLAYER, bm)

class HealAction:
	extends Action
	func _init(eManager, send, targ, targType, bm):
		super(eManager, send, targ, targType, bm)
		eventName = "Mushroom"
	func runEvent():
		target = sender
		target.reactionComplete.connect(resumeEvent)
		target.gainHealth(5)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
