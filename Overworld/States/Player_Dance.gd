extends State
class_name Player_Dance

var player = null

func _init(sStack, plyr):
	super(sStack)
	player = plyr

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	player.animState.travel("Dance")

func update(delta : float):
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	
	if(input != Vector2.ZERO):
		player.animTree.set("parameters/Dance/blend_position", input)

#Called if Player enters passage while in Dance State.
func resumeState():
	exit()

##NOT CALLED INTRINSICALLY. STATE IS USUALLY ENDED IN OW_PLAYER :P
func exit():
	super()
