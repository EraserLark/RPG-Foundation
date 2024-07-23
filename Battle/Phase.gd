extends Node
class_name Phase

var phaseName: String
var phaseManager: PhaseManager

func _init(pManager):
	phaseManager = pManager

func runPhase():
	pass

func resumePhase():
	pass

func finishPhase():
	phaseManager.phaseFinished()

func cleanPhase():
	pass
