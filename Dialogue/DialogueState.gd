extends State
class_name DialogueState

var dialogueManager: DialogueManager

func _init(sStack : StateStack, dm: DialogueManager):
	super(sStack)
	dialogueManager = dm

func handleInput(_event : InputEvent):
	if _event.is_action("ui_accept") and _event.is_pressed() and not _event.is_echo():
		dialogueManager.focusStep.confirmInput()
	
	if _event.is_action("ui_cancel") and _event.is_pressed() and not _event.is_echo():
		dialogueManager.focusStep.denyInput()

func enter(_msg := {}):
	pass

func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
	pass

func physicsUpdate(_delta : float):
	pass

func resumeState():
	dialogueManager.resumeFocusStep()

func exit():
	super()
