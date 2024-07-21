extends Event
class_name Prompt_Phase

var battleMenu
var battleManager

var promptEQ = EventQueue.new()

func _init(battleEQ, bm):
	super(battleEQ)
	battleManager = bm
	battleMenu = bm.playerEntities[0].playerUI
	bm.promptPhase = self
	
	var battleMenuState = BattleMenu_State.new(StateStack, battleMenu)
	StateStack.addState(battleMenuState)
	
func resumeEvent():
	if(promptEQ.queue.is_empty() && promptEQ.currentEvent == null):
		finishEvent()
	else:
		promptEQ.currentEvent.resumeEvent()

func finishEvent():
	var actionPhase = Action_Phase.new(eventManager, battleManager)
	eventManager.addEvent(actionPhase)
	battleManager.promptPhase = null
	super()
