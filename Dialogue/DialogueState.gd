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
	
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	if(input != Vector2.ZERO && dialogueManager.focusStep):	#breaks if focusStep is null
		dialogueManager.focusStep.moveInput(input)

func enter(_msg := {}):
	PlayerRoster.roster[0].playerActor.collisionShape.set_deferred("disabled", true)

func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
	pass

func physicsUpdate(_delta : float):
	pass

func resumeState():
	dialogueManager.resumeFocusStep()

func exit():
	PlayerRoster.roster[0].playerActor.collisionShape.set_deferred("disabled", false)
	super()
