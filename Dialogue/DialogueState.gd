extends State
class_name DialogueState

var dialogueManager: DialogueManager
var playerEntity: PlayerEntity
#var playerInput
var inputHeld:= false
var currentRoom: Room

func _init(pEntity: PlayerEntity, dm: DialogueManager):
	super(pEntity.playerStateStack)
	playerEntity = pEntity
	dialogueManager = dm
	currentRoom = playerEntity.overworldManager.overworldWorld.currentRoom

func handleInput(_event: InputEvent):
	#if _event.device != playerEntity.deviceNumber:
		#return
	
	if _event.is_action("ui_accept") and _event.is_pressed() and not _event.is_echo():
		dialogueManager.focusStep.confirmInput()
	
	if _event.is_action("ui_cancel") and _event.is_pressed() and not _event.is_echo():
		dialogueManager.focusStep.denyInput()

func update(delta: float):
	var input = Vector2.ZERO
	#input.x = MultiplayerInput.get_action_strength(playerEntity.deviceNumber, "ui_right") - MultiplayerInput.get_action_strength(playerEntity.deviceNumber, "ui_left")
	input.y = MultiplayerInput.get_action_strength(localDeviceNum, "ui_down") - MultiplayerInput.get_action_strength(localDeviceNum, "ui_up")
	if(input != Vector2.ZERO && dialogueManager.focusStep):	#breaks if focusStep is null
		if(!inputHeld):
			inputHeld = true
			dialogueManager.focusStep.moveInput(input)
	else: inputHeld = false

func enter(_msg := {}):
	if _msg.has("OwnerEntity"):
		playerEntity = _msg["OwnerEntity"]
	else:
		printerr("No Entity Owner passed for the DialogueState!")
		return
	
	playerEntity.worldActor.collisionShape.set_deferred("disabled", true)

func physicsUpdate(_delta : float):
	pass

func resumeState():
	if playerEntity.overworldManager.overworldWorld.currentRoom != currentRoom:
		dialogueManager.endDialogue()
		#exit()
	else:
		dialogueManager.resumeFocusStep()

func exit():
	playerEntity.worldActor.collisionShape.set_deferred("disabled", false)
	super()
