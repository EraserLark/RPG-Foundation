extends GameState
class_name GameState_StartPhase

var phaseManager: GameState_PhaseManager
var battleManager

func _init(pm:GameState_PhaseManager, bm: BattleManager, _msg:={}):
	phaseManager = pm
	battleManager = bm

func stackEnter(_msg := {}):
	var introCutscene = BattleIntro.new(battleManager.cutsceneManager, battleManager)

func stackResume():
	stackExit()

func stackExit():
	super()
	phaseManager.phaseFinished()

func cleanPhase():
	pass
