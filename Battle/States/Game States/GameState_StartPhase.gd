extends GameState
class_name GameState_StartPhase

var phaseManager: PhaseManager
var battleManager

func _init(bm: BattleManager, pm:PhaseManager, _msg:={}):
	phaseManager = pm
	battleManager = bm

func stackEnter(_msg := {}):
	var introCutscene = BattleIntro.new(GameStateStack.stack, battleManager.cutsceneManager, battleManager)

func stackResume():
	stackExit()

func stackExit():
	super()
	phaseManager.phaseFinished()

func cleanPhase():
	pass
