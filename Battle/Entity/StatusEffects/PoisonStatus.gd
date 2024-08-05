extends StatusEffect
class_name PoisonStatus

func _init(bm, tg, sr):
	status_name = "Posioned"
	turnCountLimit = 3
	super(status_name, turnCountLimit, tg, bm, sr, bm.actionPhase.unresolvedStatuses)
	var targets = [bm.enemyEntities, bm.playerEntities]
	statusAction = PoisonAction.new(null, self, target, Action.TargetTypes.ALL, bm)

func addToEventQueue(eq):
	var eventQueue = eq
	eventQueue.queue.append(statusAction)

func revertStatus():
	pass

class PoisonAction:
	extends Action
	func _init(eManager, send, targ, targOpts, bm):
		super(eManager, send, targ, targOpts, bm)
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.takeDamage(1, true)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
