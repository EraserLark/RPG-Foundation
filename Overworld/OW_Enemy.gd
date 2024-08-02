extends CharacterBody2D
class_name OW_Enemy

var battleScenePath = "res://Battle/battle.tscn"
@onready var player = $"../OW_Player"
@onready var world:= $"../../.."

func interactAction(interacter : OW_Player):
	world.pauseWorld()
	var bs = load(battleScenePath)
	var inst = bs.instantiate()
	get_node("/root").add_child(inst)
