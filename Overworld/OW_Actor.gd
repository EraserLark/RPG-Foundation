extends CharacterBody2D
class_name OW_Actor

@onready var battleScene = preload("res://Battle/battle.tscn")

signal send_message(name:String, message:String)

func interact():
	speak("You interacted with " + name)

func speak(message : String):
	emit_signal("send_message", name, message)
