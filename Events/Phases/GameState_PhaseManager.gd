extends Node
class_name GameState_PhaseManager

var phases: Array[GameState]
var currentPhase: GameState
var managerFinished:= false

func _init():
	pass

func determineNextPhase():
	pass
	#Set this in inherited classes

func runCurrentPhase():
	if(currentPhase != null):
		GameStateStack.addGameState(currentPhase)
		#currentPhase.stackEnter()
	else:
		determineNextPhase()

func resumeCurrentPhase():
	currentPhase.stackResume()

func phaseFinished():
	currentPhase.cleanPhase()
	determineNextPhase()

func finishManager():
	managerFinished = true
	GameStateStack.resumeCurrentState()
