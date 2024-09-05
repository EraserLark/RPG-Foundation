extends GameState
class_name GameState_StartPhase

var phaseManager: GameState_PhaseManager
var battleManager
var alreadyResumed = false

func _init(pm:GameState_PhaseManager, bm: BattleManager, _msg:={}):
	phaseManager = pm
	battleManager = bm

func stackEnter(_msg := {}):
	var introCutscene = BattleIntro.new(battleManager.cutsceneManager, battleManager)

func stackResume():
	stackExit()

func resume():
	if !alreadyResumed:
		alreadyResumed = true
		stackResume()

func stackExit():
	super()
	phaseManager.phaseFinished()

func cleanPhase():
	pass
