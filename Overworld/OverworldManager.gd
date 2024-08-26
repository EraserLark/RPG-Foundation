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
	InputManager.newPlayerJoined.connect(newControllerJoined)
	PlayerRoster.newRosterPlayer.connect(newPlayerJoined)
	print(str("New Player is connected: ", InputManager.newPlayerJoined.is_connected(newPlayerJoined)))
	
	playerEntities.assign(worldRoster.players)
	
	overworldUI.initialize(self)
	overworldWorld.initialize(self)
	worldRoster.initialize(self)
	
	#for playerInfo in PlayerRoster.roster:
		#playerInfo.entityUI = overworldUI.playerUI
		#overworldUI.playerUIRoster[0].playerPanel.playerInfo = playerInfo
	
	print("Overworld Ready Finish")

func newControllerJoined(joypadNum: int):
	PlayerRoster.addEmptySlot()
	#overworldUI.playerAnchors.determineAnchorLayout()
	var emptyUI = overworldUI.createPlayerUI()
	overworldUI.adjustMenusLayout()
	#emptyUI.currentStageAnchor = overworldUI.playerAnchors.currentAnchorLayout[PlayerRoster.roster.size()-1]
	#emptyUI.centerPlayerPanel()
	
	var menuState = MenuState.new(StateStack, emptyUI.playerPanel)
	StateStack.addState(menuState)

func newPlayerJoined(info: PlayerInfo):
	worldRoster.addNewEntity(info, overworldUI.playerUIRoster[info.playerNumber - 1])
