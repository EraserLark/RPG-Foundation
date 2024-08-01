extends StatusEffect
class_name DefenseStatus

func _init(bm, tg, sr):
	status_name = "Defense Raised"
	turnCountLimit = 1
	super(status_name, turnCountLimit, tg, bm, sr, bm.actionPhase.unresolvedStatuses)
	statusAction = DefendedAction.new(null, self, target, Action.TargetTypes.PLAYER, bm)

func runStatus():
	return statusAction

func addToEventQueue(eq):
	var eventQueue = eq
	eventQueue.queue.push_front(statusAction)

func revertStatus():
	target.decreaseDefense(1)

func endStatus():
	#target.revertStatus()
	super()

class DefendedAction:
	extends Action
	func _init(eManager, send, targ, targOpts, bm):
		super(eManager, send, targ, targOpts, bm)
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.boostDefense(1)
		var message: Array[String] = ["Defense boosted by 1 for this turn!"]
		var tbState = Textbox_State.new(StateStack, message, battleManager.battleUI.tbContainer)
		StateStack.addState(tbState)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
