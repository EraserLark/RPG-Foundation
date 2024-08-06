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
	pass

func update(delta : float):
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	player.moveDirection(input)
	
	if input != Vector2.ZERO:
		player.faceDirection(input)
		player.animState.travel("Walk")
	else:
		player.animState.travel("Idle")
	
	if Input.is_action_just_pressed("ui_accept"):
		player.castInteractRay()
	
	if Input.is_action_just_pressed("ui_cancel"):
		var menuState = MenuState.new(StateStack, owManager.ui.playerMenu)
		StateStack.addState(menuState)

func exit():
	pass
