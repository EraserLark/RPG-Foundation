extends Node
class_name DialogueManager

var focusStep: Step

func startDialogue():
	pass

func endDiaglogue():
	pass

func jumpTo(step: Step):
	focusStep = step
	runFocusStep()

func runFocusStep():
	focusStep.runStep()
