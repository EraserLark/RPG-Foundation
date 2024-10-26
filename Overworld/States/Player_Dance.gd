extends State
class_name Player_Dance

var playerActor: OW_Player
var input: DeviceInput

func _init(sStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	input = playerActor.playerEntity.input

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	playerActor.animState.travel("Dance")

func update(delta : float):
	var inputDir = Vector2.ZERO;
	inputDir.x = input.get_action_strength("ui_right") - input.get_action_strength("ui_left");
	inputDir.y = input.get_action_strength("ui_down") - input.get_action_strength("ui_up");
	
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
