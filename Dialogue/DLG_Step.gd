extends Node
class_name Step

var dialogueManager: DialogueManager

#Set to null while testing in isolated scene. Change when implemeting
func _init(dm: DialogueManager = null):
	dialogueManager = dm

func runStep():
	pass

func resumeStep():
	pass

func nextStep(currentStep: Step):
	var parent = currentStep.get_parent()
	var currentIndex = currentStep.get_index()
	var nextStep = parent.get_child(currentIndex + 1)
	
	if(nextStep == null):
		dialogueManager.endDialogue()
	else:
		dialogueManager.jumpTo(nextStep)

func getClassInstance():
	return self
