extends Node
class_name DialogueManager

var dialogueState: DialogueState
var firstStep: Step
var focusStep: Step
var stepStack: Array[Step]

var performingCast:= {}

func startDialogue(startStep: DLG_Start):
	#Create DialogueState
	dialogueState = DialogueState.new(StateStack, self)
	StateStack.addState(dialogueState)
	
	var timeline = Helper.getAllChildren(startStep)
	startStep.dialogueManager = self
	for step in timeline:
		if(step is Step):
			step.dialogueManager = self
	
	firstStep = startStep
	focusStep = startStep
	runFocusStep()

func endDialogue():
	dialogueState.exit()
	focusStep = null
	firstStep.queue_free()

func jumpTo(step: Step):
	focusStep = step
	runFocusStep()

func runFocusStep():
	focusStep.runStep()

func resumeFocusStep():
	focusStep.resumeStep()
