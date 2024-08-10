extends State
class_name Player_Active

var player = null

func _init(sStack, plyr):
	super(sStack)
	player = plyr

func handleInput(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		player.castInteractRay()
	
	#if(event.is_action_pressed("ui_cancel")):
		#player.openMenu()

func enter(msg := {}):
	pass

func update(delta : float):
	if(player == null):
		return
	
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	player.moveDirection(input)
	
	if input != Vector2.ZERO:
		var dancing = player.faceDirection(input)
		if(dancing):
			return
		
		player.animState.travel("Walk")
	else:
		player.animState.travel("Idle")
	
	#if Input.is_action_just_pressed("ui_accept"):
		#player.castInteractRay()
	
	if Input.is_action_just_pressed("ui_cancel"):
		player.openMenu()

func exit():
	pass
