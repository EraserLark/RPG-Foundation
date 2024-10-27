extends Sprite2D

func _ready():
	$AnimationPlayer.play("Opening")

func CloseBeam():
	$AnimationPlayer.play("Closing")
