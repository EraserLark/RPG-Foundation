extends State
class_name Player_Active

var playerActor: OW_Player
var input: DeviceInput

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	input = playerActor.playerEntity.input

func handleInput(event : InputEvent):
	#if event.device != playerActor.playerEntity.deviceNumber:
		#return
	
	if(event.is_action_pressed("ui_accept")):
		playerActor.castInteractRay()
	elif(event.is_action_pressed("ui_cancel")):
		playerActor.openMenu()

func enter(msg := {}):
	pass

func update(delta : float):
	if(playerActor == null):
		return
	
	##Get input vector
	var inputDir = Vector2.ZERO
	inputDir = input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	##Convert joystick movement to 8 Directions
	if input.is_joypad() && inputDir != Vector2.ZERO:
		inputDir = Helper.convertToEightDir(inputDir)
	
	##Move playerActor
	playerActor.moveDirection(inputDir)
	
	if inputDir != Vector2.ZERO:
		var dancing = playerActor.faceDirection(inputDir)
		if(dancing):
			return
		playerActor.animState.travel("Walk")
	else:
		playerActor.animState.travel("Idle")

func physicsUpdate(_delta: float):
	playerActor.physicsUpdate(_delta)

func interruptState(interruptor):
	super(interruptor)
	
	if interruptor is not Player_Dance and interruptor is not Player_Entrance:
		#Pause animation
		playerActor.animTree.active = false

func resumeState():
	playerActor.velocity = Vector2.ZERO
	playerActor.animTree.active = true

func exit():
	pass

func changeDeviceNum(newNum: int):
	super(newNum)
	input = stateStack.playerEntity.input	#Update DeviceInput
