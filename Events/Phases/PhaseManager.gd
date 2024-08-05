extends Node
class_name PhaseManager

var phases: Array[Phase]
var currentPhase: Phase
var managerFinished:= false

func _init():
	pass

func determineNextPhase():
	pass
	#Set this in inherited classes

func runCurrentPhase():
	if(currentPhase != null):
		currentPhase.runPhase()
	else:
		determineNextPhase()

func resumeCurrentPhase():
	currentPhase.resumePhase()

func phaseFinished():
	currentPhase.cleanPhase()
	determineNextPhase()

func finishManager():
	managerFinished = true
	StateStack.resumeCurrentState()