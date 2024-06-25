extends OW_Actor

@export var speed := 500;

@onready var animTree = $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var interactRay = $"RayCast2D"

var rayLength := 72;

func _ready():
	pass

func _process(delta):
	#var input = Vector2.ZERO;
	#input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	#input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	#velocity = input.normalized() * speed;
	#move_and_slide()
	#
	#if input != Vector2.ZERO:
		#interactRay.target_position = input * rayLength;
		#animTree.set("parameters/Idle/blend_position", input)
		#animTree.set("parameters/Walk/blend_position", input)
		#animState.travel("Walk")
	#else:
		#animState.travel("Idle")
	#
	#if Input.is_action_just_pressed("ui_accept"):
		#var interactee = interactRay.get_collider()
		#if interactee is OW_Actor:
			#interactee.interact();
	pass
