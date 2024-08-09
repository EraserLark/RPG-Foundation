extends Node
class_name DialogueManager

var focusStep: Step

func startDialogue(startStep: DLG_Start):
	var timeline = Helper.getAllChildren(startStep)
	startStep.dialogueManager = self
	for step in timeline:
		step.dialogueManager = self
	
	focusStep = startStep
	runFocusStep()

func endDialogue():
	focusStep = null

func jumpTo(step: Step):
	focusStep = step
	runFocusStep()

func runFocusStep():
	focusStep.runStep()