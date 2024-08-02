extends Node2D

var actorScene:= preload("res://Overworld/OW_Player.tscn")
@onready var owm:= $"../../.."
@onready var camera := $"../Camera2D"

signal actor_speaking(name, message)

func _ready():
	for playerInfo in PlayerRoster.roster:
		addActor(playerInfo, camera.get_screen_center_position())

func addActor(playerInfo: PlayerInfo, pos: Vector2):
	var playerActor = actorScene.instantiate()
	playerActor.initialize(owm)
	self.add_child(playerActor)
	camera.setTarget(playerActor)
	return playerActor

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)
