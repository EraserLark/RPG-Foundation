extends Node

@export var roster: Array[PlayerInfo]

func _ready():
	for x in roster.size():
		roster[x].playerNumber = x
		roster[x].initialize()
