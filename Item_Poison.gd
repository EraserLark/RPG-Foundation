extends Item
class_name Item_Poison

func _init(bm : BattleManager):
	super(bm)
	var targets = bm.enemyEntities
	targets += bm.playerEntities
	itemAction = PoisoningAction.new(null, bm.playerEntities[0], null, Action.TargetTypes.ALL, bm)

class PoisoningAction:
	extends Action
	func _init(eManager, send, targ, targType, bm):
		super(eManager, send, targ, targType, bm)
		eventName = "Poison Pudding"
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.gainStatus("Poison")
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
