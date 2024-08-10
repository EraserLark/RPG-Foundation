extends Node
class_name Step

var dialogueManager: DialogueManager

#Set to null while testing in isolated scene. Change when implemeting
#func _init(dm: DialogueManager):
	#dialogueManager = dm

func runStep():
	pass

func resumeStep():
	pass

func getNextStep(currentStep: Step) -> Step:
	var parent = currentStep.get_parent()
	var currentIndex = currentStep.get_index()
	var nextStep = parent.get_child(currentIndex + 1)
	return nextStep

func advanceNextStep(currentStep: Step):
	var nextStep = getNextStep(currentStep)
	if(nextStep == null):
		dialogueManager.endDialogue()
	else:
		dialogueManager.jumpTo(nextStep)

#Recieved input with intention of confirming
func confirmInput():
	pass

#Recieved input with intention of denying
func denyInput():
	pass

func getClassInstance():
	return self
