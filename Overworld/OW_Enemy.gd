extends CharacterBody2D
class_name OW_Enemy

var battleScenePath = "res://Battle/battle.tscn"
@onready var player = $"../OW_Player"

signal send_message(name:String, message:String)

func interact():
	var bs = load(battleScenePath)
	var inst = bs.instantiate()
	get_node("/root").add_child(inst)
	#var error = get_tree().change_scene_to_file(battleScenePath)
	#print(error)

func speak(message : String):
	emit_signal("send_message", name, message)
