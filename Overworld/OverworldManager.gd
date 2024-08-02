extends Node
class_name OverworldManager

@onready var ui:= $CanvasLayer/OW_UI
@onready var world:= $World

@onready var player:= $World/CastList/OW_Player

func _ready():
	world.get_node("CastList").get_child(0).initialize(self)
	
	player.playerInfo.entityUI = ui.player
	
	ui.playerMenu.player = player
	ui.playerMenu.playerInfo = player.playerInfo
