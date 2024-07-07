extends CharacterBody2D
class_name OW_Enemy

@onready var battleScene = preload("res://Battle/battle.tscn")
@onready var player = $"../OW_Player"

signal send_message(name:String, message:String)

func interact():
	var bs = battleScene.instantiate()
	get_node("/root").add_child(bs)

func speak(message : String):
	emit_signal("send_message", name, message)
