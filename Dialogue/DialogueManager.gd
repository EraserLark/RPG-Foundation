extends Node
class_name DialogueManager

var dialogueState: DialogueState
var playerEntity: Entity
var firstStep: Step
var focusStep: Step
var stepStack: Array[Step]

#var ownerEntity: Entity
var performingCast:= {}
var cutsceneMarks:= {}
var roomOther: Node2D

signal timelineComplete

func _init(entity: Entity):
	playerEntity = entity

func startDialogue(startStep: DLG_Start):
	#Create DialogueState
	dialogueState = DialogueState.new(playerEntity, self)
	playerEntity.playerStateStack.addState(dialogueState, {"OwnerEntity": playerEntity})
	
	var timeline = Helper.getAllChildren(startStep)
	startStep.dialogueManager = self
	for step in timeline:
		if(step is Step):
			step.dialogueManager = self
	
	firstStep = startStep
	focusStep = startStep
	runFocusStep()

func endDialogue():
	emit_signal("timelineComplete")	#Reenable interact areas for npcs starring in timeline
	
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
