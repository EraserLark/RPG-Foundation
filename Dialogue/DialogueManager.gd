extends Node
class_name DialogueManager

var dialogueState: DialogueState
var firstStep: Step
var focusStep: Step
var stepStack: Array[Step]

var ownerEntity: Entity
var performingCast:= {}
var cutsceneMarks:= {}
var roomOther: Node2D

func _init(entity: Entity):
	ownerEntity = entity

func startDialogue(startStep: DLG_Start):
	#Create DialogueState
	dialogueState = DialogueState.new(ownerEntity.playerStateStack, self)
	ownerEntity.playerStateStack.addState(dialogueState, {"OwnerEntity": ownerEntity})
	
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
