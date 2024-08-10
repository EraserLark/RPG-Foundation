extends Step
class_name DLG_Start

@export var focusDestination: Step

#Set to null while testing in isolated scene. Change when implemeting
#func _init(dm: DialogueManager = null):
	#super(dm)

func _ready():
	#if dialogueManager == null:
		#dialogueManager = DialogueManager.new()
	#runStep()
	pass

func runStep():
	if(focusDestination == null):
		focusDestination = get_child(0)
	
	dialogueManager.jumpTo(focusDestination)
