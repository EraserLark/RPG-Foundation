extends State

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	#owner.animState.travel("Idle")
	pass

func update(delta : float):
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	owner.velocity = input.normalized() * owner.speed;
	owner.move_and_slide()
	
	if input != Vector2.ZERO:
		owner.interactRay.target_position = input * owner.rayLength;
		owner.animTree.set("parameters/Idle/blend_position", input)
		owner.animTree.set("parameters/Walk/blend_position", input)
		owner.animState.travel("Walk")
	else:
		owner.animState.travel("Idle")
	
	if Input.is_action_just_pressed("ui_accept"):
		var interactee = owner.interactRay.get_collider()
		if interactee is OW_Actor:
			interactee.interact();
			#stateMachine.transition_to("Talking")

func physicsUpdate(delta : float):
	pass

func exit():
	pass
