extends Node
class_name OverworldManager

var actorScene:= preload("res://Overworld/OW_Player.tscn") 

@onready var ui:= $CanvasLayer/OW_UI
@onready var world:= $World

var playerRoster
@onready var playerActor:= $World/CastList/OW_Player
@onready var castList:= $World/Room/CastList

func _ready():
	world.get_child(0).get_node("CastList").get_child(0).initialize(self)
	
	for playerInfo in PlayerRoster.roster:
		var playerActor = actorScene.instantiate()
		castList.add_child(playerActor)
		playerInfo.entityUI = ui.playerUI
		
		ui.playerMenu.player = playerActor
		ui.playerMenu.playerInfo = playerInfo
