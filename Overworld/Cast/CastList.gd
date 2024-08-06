extends Node2D

var actorScene:= preload("res://Overworld/Cast/OW_Player.tscn")
@onready var owm:= $"../../.."
@onready var room:= $".."
@onready var passages:= $"../Passages"
@onready var camera := $"../Camera2D"

signal actor_speaking(name, message)

func _ready():
	for playerInfo in PlayerRoster.roster:
		addActor(playerInfo, camera.get_screen_center_position())

func addActor(playerInfo: PlayerInfo, pos: Vector2):
	var playerActor = actorScene.instantiate()
	playerActor.initialize(owm)
	self.add_child(playerActor)
	
	if(room.playerSpawnPort == null):
		playerActor.position = Vector2.ZERO
	else:
		var port = room.playerSpawnPort
		await passages.ready
		playerActor.position = passages.getSpawnPoint(port)
		playerActor.faceDirection(passages.getSpawnDir(port))
	
	camera.setTarget(playerActor)
	
	playerInfo.setActor(playerActor)
	
	return playerActor

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)
