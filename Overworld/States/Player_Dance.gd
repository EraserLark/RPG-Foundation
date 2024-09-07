extends State
class_name Player_Dance

var player: OW_Player
var input: DeviceInput

func _init(sStack, plyr: OW_Player):
	super(sStack)
	player = plyr
	input = player.playerEntity.input

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	player.animState.travel("Dance")

func update(delta : float):
	var inputDir = Vector2.ZERO;
	inputDir.x = input.get_action_strength("ui_right") - input.get_action_strength("ui_left");
	inputDir.y = input.get_action_strength("ui_down") - input.get_action_strength("ui_up");
	
	if(inputDir != Vector2.ZERO):
		player.animTree.set("parameters/Dance/blend_position", inputDir)

#Called if Player enters passage while in Dance State.
func resumeState():
	exit()

##NOT CALLED INTRINSICALLY. STATE IS USUALLY ENDED IN OW_PLAYER :P
func exit():
	super()
