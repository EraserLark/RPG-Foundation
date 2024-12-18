extends State
class_name Player_Dance

var playerActor: OW_Player
var localDeviceNum: int
var localInput: DeviceInput
#var input: DeviceInput

func _init(sStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	localInput = playerActor.playerEntity.input
	localDeviceNum = playerActor.playerEntity.deviceNumber
	#input = playerActor.playerEntity.input

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	playerActor.animState.travel("Dance")

func update(_delta: float, deviceNum: int):
	if localDeviceNum != deviceNum:
		localDeviceNum = deviceNum
		localInput = playerActor.playerEntity.input
	
	var inputDir = Vector2.ZERO;
	inputDir.x = MultiplayerInput.get_action_strength(deviceNum, "ui_right") - MultiplayerInput.get_action_strength(deviceNum, "ui_left");
	inputDir.y = MultiplayerInput.get_action_strength(deviceNum, "ui_down") - MultiplayerInput.get_action_strength(deviceNum, "ui_up");
	
	if(inputDir != Vector2.ZERO):
		playerActor.animTree.set("parameters/Dance/blend_position", inputDir)

func interruptState(interruptor):
	super(interruptor)
	
	if interruptorClass is TransitionState:
		#Pause animation
		playerActor.animPlayer.pause()
	else:
		#End Dance
		playerActor.animState.travel("Idle")

#Called if Player enters passage while in Dance State.
func resumeState():
	if interrupted:
		interrupted = false
		if interruptorClass is TransitionState:
			#End Dance
			exit()
		else:
			#Resume animation
			playerActor.animPlayer.play()

##NOT CALLED INTRINSICALLY. STATE IS USUALLY ENDED IN OW_PLAYER :P
func exit():
	super()
