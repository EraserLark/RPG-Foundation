extends Event
class_name Prompt_Phase

var thisEventManager = EventQueue.new()

func _init(eManager, battleMenu):
	super(eManager)
	var battleMenuState = BattleMenu_State.new(StateStack, battleMenu)
	StateStack.addState(battleMenuState)

func resumeEvent():
	finishEvent()

func finishEvent():
	var actionPhase = Action_Phase.new(eventManager)
	eventManager.addEvent(actionPhase)
	eventManager.popQueue()
