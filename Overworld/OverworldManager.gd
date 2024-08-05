extends Node
class_name OverworldManager

@onready var ui:= $CanvasLayer/OW_UI
@onready var world:= $World

var playerRoster
@onready var playerActor:= $World/CastList/OW_Player
@onready var castList:= $World/Room/CastList

func _ready():
	await get_tree().root.ready
	
	for playerInfo in PlayerRoster.roster:
		#var playerActor = castList.addActor(playerInfo)
		playerInfo.entityUI = ui.playerUI
		
		ui.playerMenu.player = playerActor
		ui.playerMenu.playerInfo = playerInfo
