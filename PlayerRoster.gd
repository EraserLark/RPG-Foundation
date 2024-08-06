extends Node

@export var roster: Array[PlayerInfo]

func _ready():
	var pState = Player_Active.new(StateStack, roster[0].playerActor)
	roster[0].owPlayerState = pState
	StateStack.addState(pState)
