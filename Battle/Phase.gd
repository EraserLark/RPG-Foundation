extends Node
class_name Phase

var phaseName : String
var phaseManager = null

func _init(pManager):
	phaseManager = pManager

func runPhase():
	pass

func resumePhase():
	pass

func finishPhase():
	pass

func cleanPhase():
	pass
