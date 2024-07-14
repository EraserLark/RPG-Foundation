extends Item
class_name Item_Poison

func _init(bm : BattleManager):
	super(bm)
	var targets = bm.enemyEntities.duplicate()
	targets += bm.playerEntities
	itemAction = PoisoningAction.new(null, bm.playerEntities[0], null, targets)

class PoisoningAction:
	extends Action
	func _init(eManager, send, targ, targOpts):
		super(eManager, send, targ, targOpts)
		eventName = "Poison Pudding"
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.gainStatus("Poison")
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
