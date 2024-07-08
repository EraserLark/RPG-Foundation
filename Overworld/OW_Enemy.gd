extends CharacterBody2D
class_name OW_Enemy

var battleScenePath = "res://Battle/battle.tscn"
@onready var player = $"../OW_Player"

func interactAction(interacter : OW_Player):
	var bs = load(battleScenePath)
	var inst = bs.instantiate()
	get_node("/root").add_child(inst)
	#var error = get_tree().change_scene_to_file(battleScenePath)
	#print(error)
