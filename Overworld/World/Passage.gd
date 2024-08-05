extends Area2D
class_name Passage

@onready var currentRoom:= $"../.."
@onready var spawnPoint:= $SpawnPoint
@export var leadsToRoom: String
@export var leadsToPassage: int

func _on_body_entered(body):
	if body is OW_Player:
		goToNextRoom()

func goToNextRoom():
	#Add transition state, player walks out (follows Path2D?)
	currentRoom.exitRoom(leadsToRoom, leadsToPassage)
