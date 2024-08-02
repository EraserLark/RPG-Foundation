extends Area2D
class_name Passage

@onready var currentRoom:= $"../.."
@export var leadsTo: String

func _on_body_entered(body):
	if body is OW_Player:
		pass

func goToNextRoom():
	#Add transition state, player walks out (follows Path2D?)
	currentRoom.exitRoom(leadsTo)
