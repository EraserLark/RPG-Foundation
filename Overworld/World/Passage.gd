extends Area2D
class_name Passage

@onready var owManager:= $"../../"
@onready var currentRoom:= $"../.."
@onready var spawnPoint:= $SpawnPoint

@export var leadsToRoom: String
@export var leadsToPassage: int
enum SPAWN_DIR {E, NE, N, NW, W, SW, S, SE}	#int values correspond to unit circle
@export var spawnFacing: SPAWN_DIR

func _on_body_entered(body):
	if body is OW_Player:
		goToNextRoom()

func goToNextRoom():
	#Add transition state, player walks out (follows Path2D?)
	currentRoom.exitRoom(leadsToRoom, leadsToPassage)
