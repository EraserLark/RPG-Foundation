extends Item
class_name Item_Poison

func _init():
	super("Poison Pudding")
	#var targets = bm.enemyEntities
	#targets += bm.playerEntities
	itemAction = PoisoningAction.new(null, null, null, Action.TargetTypes.ALL, null)

class PoisoningAction:
	extends Action
	func _init(eManager, send, targ, targType, stgmn: StageManager):
		super(eManager, send, targ, targType, stgmn)
		eventName = "Poison Pudding"
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.gainStatus(Status.Type.POISON)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
