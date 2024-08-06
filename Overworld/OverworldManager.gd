extends Node
class_name OverworldManager

@onready var ui:= $CanvasLayer/OW_UI
@onready var world:= $World

var playerRoster
@onready var playerActor:= $World/CastList/OW_Player
@onready var castList:= $World/Room/CastList

@onready var cutsceneManager:= $CutsceneManager

func _ready():
	await get_tree().root.ready
	
	for playerInfo in PlayerRoster.roster:
		playerInfo.entityUI = ui.playerUI
		ui.playerMenu.playerInfo = playerInfo
