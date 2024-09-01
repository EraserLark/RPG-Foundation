extends State
class_name DialogueState

var dialogueManager: DialogueManager
var playerEntity: Entity

func _init(pEntity: Entity, dm: DialogueManager):
	super(pEntity.playerStateStack)
	dialogueManager = dm

func handleInput(_event : InputEvent):
	if _event.device != playerEntity.deviceNumber:
		return
	
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
	if _msg.has("OwnerEntity"):
		playerEntity = _msg["OwnerEntity"]
	else:
		printerr("No Entity Owner passed for the DialogueState!")
		return
	
	playerEntity.entityActor.collisionShape.set_deferred("disabled", true)

func update(_delta : float):
	#if Input.is_action_just_pressed("ui_accept"):
	pass

func physicsUpdate(_delta : float):
	pass

func resumeState():
	dialogueManager.resumeFocusStep()

func exit():
	playerEntity.entityActor.collisionShape.set_deferred("disabled", false)
	super()
