extends State
class_name Player_Active

var player = null
var owManager

func _init(sStack, plyr, om):
	super(sStack)
	player = plyr
	owManager = om

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	#player.animState.travel("Idle")
	pass

func update(delta : float):
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	player.velocity = input.normalized() * player.speed;
	player.move_and_slide()
	
	if input != Vector2.ZERO:
		player.interactRay.target_position = input * player.rayLength;
		player.animTree.set("parameters/Idle/blend_position", input)
		player.animTree.set("parameters/Walk/blend_position", input)
		player.animState.travel("Walk")
	else:
		player.animState.travel("Idle")
	
	if Input.is_action_just_pressed("ui_accept"):
		var interactee = player.interactRay.get_collider()
		if(interactee is StaticBody2D):
			interactee = interactee.get_parent()
		
		player.interact(interactee)
	
	if Input.is_action_just_pressed("ui_cancel"):
		var menuState = PlayerMenu_State.new(StateStack, owManager.ui)
		StateStack.addState(menuState)

func physicsUpdate(delta : float):
	pass

func exit():
	pass
