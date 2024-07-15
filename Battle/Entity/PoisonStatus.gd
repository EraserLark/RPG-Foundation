extends StatusEffect
class_name PoisonStatus

func _init(bm, tg, sr):
	status_name = "Posioned"
	turnCount = 3
	super(bm, status_name, turnCount, tg, sr)
	var targets = [bm.enemyEntities, bm.playerEntities]
	statusAction = PoisonAction.new(null, self, target, Action.TargetTypes.ALL, battleManager)

func addToEventQueue(eq):
	var eventQueue = eq
	eventQueue.queue.append(statusAction)

class PoisonAction:
	extends Action
	func _init(eManager, send, targ, targOpts, bm):
		super(eManager, send, targ, targOpts, bm)
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.takeDamage(1)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
