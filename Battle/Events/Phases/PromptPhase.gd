extends Phase
class_name Prompt_Phase

var battleMenu
var battleManager: BattleManager

#var promptEQ = EventQueue.new(GameStateStack.stack)	#Unused?

func _init(battlePM, bm):
	super(battlePM)
	battleManager = bm
	battleMenu = bm.playerEntities[0].playerUI

func runPhase():
	var battleMenuState = MenuState.new(GameStateStack.stack, battleManager.battleUI.playerUIRoster[0].playerPanel)
	GameStateStack.addState(battleMenuState)

func resumePhase():
	finishPhase()

func finishPhase():
	super()
