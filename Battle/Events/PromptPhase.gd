extends Event
class_name Prompt_Phase

var battleMenu
var battleManager

func _init(battleEQ, bm):
	super(battleEQ)
	battleManager = bm
	battleMenu = bm.playerEntity.playerUI
	var battleMenuState = BattleMenu_State.new(StateStack, battleMenu)
	StateStack.addState(battleMenuState)
	
func resumeEvent():
	finishEvent()

func finishEvent():
	var actionPhase = Action_Phase.new(eventManager, battleManager)
	eventManager.addEvent(actionPhase)
	eventManager.popQueue()
	#queue_free()
