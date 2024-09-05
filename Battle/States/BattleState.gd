extends GameState
class_name Battle_State

var battlePM: GameState_PhaseManager
var battleManager: BattleManager

enum battlePhases {START, PROMPT, ACTION, FINISH}
var currentPhase: battlePhases

func _init(bm):
	battleManager = bm
	battlePM = PM_Battle.new(battleManager)
	super()

func stackEnter(_msg:= {}):
	super()
	battlePM.runCurrentPhase()

func stackResume():
	if(battlePM.managerFinished):
		stackExit()
	else:
		battlePM.determineNextPhase()

func stackExit():
	set_process_input(false)
	super()
	battleManager.queue_free()
