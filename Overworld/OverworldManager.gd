extends StageManager
class_name OverworldManager

##Children references
@onready var overworldWorld:= $World
@onready var worldRoster:= $WorldRoster
@onready var overworldUI:= $CanvasLayer/OW_UI
@onready var musicPlayer:= $World/AudioStreamPlayer
@onready var cutsceneManager:= $CutsceneManager
#@onready var playerActor:= $World/CastList/OW_Player
#@onready var castList:= $World/Room/CastList

##Parent references
#None

##Non export vars
var playerEntities: Array[OWEntity_Player]

func _ready():
	print("Overworld Ready Start")
	#await get_tree().root.ready
	
	playerEntities.assign(worldRoster.players)
	
	overworldUI.initialize(self)
	overworldWorld.initialize(self)
	worldRoster.initialize(self)
	
	#for playerInfo in PlayerRoster.roster:
		#playerInfo.entityUI = overworldUI.playerUI
		#overworldUI.playerUIRoster[0].playerPanel.playerInfo = playerInfo
	
	print("Overworld Ready Finish")
