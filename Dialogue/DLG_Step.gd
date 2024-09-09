extends Node
class_name Step

var dialogueManager: DialogueManager
var availableActors: Array[String]

#Set to null while testing in isolated scene. Change when implemeting
#func _init(dm: DialogueManager):
	#dialogueManager = dm

func runStep():
	pass

func resumeStep():
	pass

func endStepEarly():
	pass

func getNextStep(currentStep: Step) -> Step:
	var parent = currentStep.get_parent()
	var currentIndex = currentStep.get_index()
	var nextStep = parent.get_child(currentIndex + 1)
	return nextStep

func advanceNextStep(currentStep: Step):
	var nextStep = getNextStep(currentStep)
	if(nextStep != null):
		dialogueManager.jumpTo(nextStep)
	else:
		if(dialogueManager.stepStack.size() > 0):
			var prevStep = dialogueManager.stepStack.pop_front()
			dialogueManager.jumpTo(prevStep)
		else:
			dialogueManager.endDialogue()

#Recieved input with intention of confirming
func confirmInput():
	pass

#Recieved input with intention of denying
func denyInput():
	pass

func moveInput(input: Vector2):
	pass

func getClassInstance():
	return self
