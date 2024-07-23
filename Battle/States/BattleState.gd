extends State
class_name Battle_State

var battlePM
var battleManager

enum battlePhases {START, PROMPT, ACTION, FINISH}
var currentPhase: battlePhases

func _init(sStack: StateStack, bm):
	stateStack = sStack
	battleManager = bm
	
	battlePM = PM_Battle.new(battleManager)

func handleInput(_event: InputEvent):
	pass

func enter(_msg:= {}):
	battlePM.runCurrentPhase()

func resumeState():
	if(battlePM.managerFinished):
		exit()
	else:
		battlePM.resumeCurrentPhase()

func exit():
	set_process_input(false)
	super()
	battleManager.queue_free()
