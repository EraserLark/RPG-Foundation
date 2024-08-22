extends StageManager
class_name OverworldManager

##Children references
@onready var overworldWorld:= $World
@onready var overworldUI:= $CanvasLayer/OW_UI
@onready var musicPlayer:= $World/AudioStreamPlayer
@onready var cutsceneManager:= $CutsceneManager
#@onready var playerActor:= $World/CastList/OW_Player
#@onready var castList:= $World/Room/CastList

##Parent references
#None

##Non export vars
var playerRoster

func _ready():
	print("Overworld Ready Start")
	#await get_tree().root.ready
	
	for playerInfo in PlayerRoster.roster:
		playerInfo.entityUI = overworldUI.playerUI
		overworldUI.playerMenu.playerInfo = playerInfo
	
	overworldWorld.initialize(self)
	overworldUI.initialize(self)
	
	print("Overworld Ready Finish")
