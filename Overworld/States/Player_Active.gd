extends State
class_name Player_Active

var player: OW_Player

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	player = plyr

func handleInput(event : InputEvent):
	if event.device != player.playerEntity.rosterNumber:
		return
	
	if(event.is_action_pressed("ui_accept")):
		player.castInteractRay()
	elif(event.is_action_pressed("ui_cancel")):
		player.openMenu()
	
	#if(event.is_action_pressed("ui_cancel")):
		#player.openMenu()

func enter(msg := {}):
	pass

func update(delta : float):
	if(player == null):
		return
	
	#if(InputEvent.device != player.playerEntity.rosterNumber):
		#return
	
	var input = Vector2.ZERO;
	#input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	#input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print(str("Input: ", input))
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
	
	#if Input.is_action_just_pressed("ui_cancel"):
		#player.openMenu()

func resumeState():
	#player.owManager.overworldUI.playerMenu.refreshMenu()
	pass

func exit():
	pass
