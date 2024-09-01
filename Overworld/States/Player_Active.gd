extends State
class_name Player_Active

var player: OW_Player
var input: DeviceInput

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	player = plyr
	input = player.playerEntity.input

func handleInput(event : InputEvent):
	if event.device != player.playerEntity.deviceNumber:
		return
	
	if(event.is_action_pressed("ui_accept")):
		player.castInteractRay()
	elif(event.is_action_pressed("ui_cancel")):
		player.openMenu()

func enter(msg := {}):
	pass

func update(delta : float):
	if(player == null):
		return
	
	##Get input vector
	var inputDir = Vector2.ZERO
	inputDir = input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	##Convert joystick movement to 8 Directions
	if input.is_joypad() && inputDir != Vector2.ZERO:
		inputDir = Helper.convertToEightDir(inputDir)
	
	##Move player
	player.moveDirection(inputDir)
	
	if inputDir != Vector2.ZERO:
		var dancing = player.faceDirection(inputDir)
		if(dancing):
			return
		
		player.animState.travel("Walk")
	else:
		player.animState.travel("Idle")

func physicsUpdate(_delta: float):
	player.physicsUpdate(_delta)

func resumeState():
	player.velocity = Vector2.ZERO

func exit():
	pass
