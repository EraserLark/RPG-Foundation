@tool
extends Step
class_name DLG_Walk

@export var targetPosition: Vector2

func runStep():
	dialogueManager.performingCast["Godot Guy"].walkFinished.connect(walkFinished)
	dialogueManager.performingCast["Godot Guy"].setNavTarget(targetPosition)

func walkFinished():
	dialogueManager.performingCast["Godot Guy"].walkFinished.disconnect(walkFinished)
	advanceNextStep(self)
