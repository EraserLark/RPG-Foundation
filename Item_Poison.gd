extends Item
class_name Item_Poison

func _init():
	itemAction = PoisoningAction.new(null, null, null)

class PoisoningAction:
	extends Action
	func _init(eManager, send, targ):
		super(eManager, send, targ)
		eventName = "Poison Pudding"
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.gainStatus("Poison")
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
