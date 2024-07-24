extends Phase
class_name Prompt_Phase

var battleMenu
var battleManager

var promptEQ = EventQueue.new()

func _init(battlePM, bm):
	super(battlePM)
	battleManager = bm
	battleMenu = bm.playerEntities[0].playerUI

func runPhase():
	var battleMenuState = BattleMenu_State.new(StateStack, battleMenu)
	StateStack.addState(battleMenuState)

func resumePhase():
	if(promptEQ.queue.is_empty() && promptEQ.currentEvent == null):
		finishPhase()
	else:
		promptEQ.currentEvent.resumeEvent()

func finishPhase():
	super()