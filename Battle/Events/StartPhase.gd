extends Phase
class_name Start_Phase

var battleUI
var battleManager

func _init(battlePM, bm):
	super(battlePM)
	battleManager = bm
	battleUI = bm.battleUI

func runPhase():
	var introCutscene = BattleIntro.new(StateStack, battleManager.cutsceneManager, battleManager)
	StateStack.addState(introCutscene)

func resumePhase():
	finishPhase()

func finishPhase():
	super()

func cleanPhase():
	pass
