extends MinigameFoundation
class_name MG_OneScreenPlatformer

@onready var player:= $Stage/CharacterBody2D
@onready var goal:= $Stage/Goal

var grounded:= false
var speed:= 5
var jumpForce: int = 200
var goalGot:= false

func update(delta):
	super(delta)

func physicsUpdate(_delta : float):
	apply_gravity();
	
	var input = Vector2.ZERO;
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	
	if input.x == 0:
		apply_friction();
	else:
		apply_acceleration(input.x);
	
	if player.is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			player.velocity.y = -jumpForce;
	#else:
		#if Input.is_action_just_released("ui_up") and player.velocity.y < -30:
			#player.velocity.y = -30;
		#if player.velocity.y > 10:
			#player.velocity.y += 20;
	
	player.move_and_slide()

func apply_gravity():
	player.velocity.y += 8;

func apply_friction():
	player.velocity.x = move_toward(player.velocity.x, 0, 10)

func apply_acceleration(amount):
	player.velocity.x = move_toward(player.velocity.x, 50 * amount, 10)

func guageSuccess():
	if(goalGot):
		return 1
	else:
		return 0

func _on_goal_body_entered(body):
	goal.queue_free()
	goalGot = true
