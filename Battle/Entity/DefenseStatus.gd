extends StatusEffect
class_name DefenseStatus

func _init(bm, tg, sr):
	status_name = "Defense Raised"
	turnCount = 1
	super(bm, status_name, turnCount, tg, sr)
	statusAction = DefendedAction.new(null, self, target, bm.players, battleManager)

func runStatus():
	return statusAction

func addToEventQueue(eq):
	var eventQueue = eq
	eventQueue.queue.push_front(statusAction)

func endStatus():
	target.revertStatus()
	super()

class DefendedAction:
	extends Action
	var battleManager
	func _init(eManager, send, targ, targOpts, bm):
		super(eManager, send, targ, targOpts)
		battleManager = bm
	func runEvent():
		target.reactionComplete.connect(resumeEvent)
		target.boostDefense(1)
		var message = "Defense boosted by 1 for this turn!"
		var tbState = Textbox_State.new(StateStack, battleManager.battleUI.textbox, message)
		StateStack.addState(tbState)
	func resumeEvent():
		target.reactionComplete.disconnect(resumeEvent)
		finishEvent()
