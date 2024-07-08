extends StatusEffect
class_name PoisonStatus

func _init(bm, tg, sr):
	status_name = "Posioned"
	turnCount = 3
	super(bm, status_name, turnCount, tg, sr)
	statusAction = PoisonAction.new(null, self, target)

class PoisonAction:
	extends Action
	func _init(eManager, send, targ):
		super(eManager, send, targ)
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.takeDamage(1)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
