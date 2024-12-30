extends Sprite2D

@onready var audioPlayer:= $AudioStreamPlayer2D

func _ready():
	$AnimationPlayer.play("Opening")

func CloseBeam():
	$AnimationPlayer.play("Closing")
