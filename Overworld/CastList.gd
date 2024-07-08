extends Node2D

signal actor_speaking(name, message)

func _ready():
	#iterate through child nodes, connect send_message to actorSpeak
	get_node("Godot Guy").send_message.connect(actorSpeak)

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)
