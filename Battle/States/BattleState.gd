extends GameState
class_name Battle_State

var battlePM
var battleManager

enum battlePhases {START, PROMPT, ACTION, FINISH}
var currentPhase: battlePhases

func _init(bm):
	battleManager = bm
	battlePM = PM_Battle.new(battleManager)
	super()

func stackEnter(_msg:= {}):
	battlePM.runCurrentPhase()

func stackResume():
	if(battlePM.managerFinished):
		stackExit()
	else:
		battlePM.resumeCurrentPhase()

func stackExit():
	set_process_input(false)
	super()
	battleManager.queue_free()
