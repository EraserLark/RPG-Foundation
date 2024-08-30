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
	
	playerEntities.assign(worldRoster.players)
	
	overworldUI.initialize(self)
	overworldWorld.initialize(self)
	worldRoster.initialize(self)
	
	print("Overworld Ready Finish")

func newControllerJoined(joypadNum: int):
	var emptyEntity = PlayerRoster.addEmptySlot(self, joypadNum)
	#var emptyUI = overworldUI.createPlayerUI()
	#overworldUI.adjustMenusLayout()
	
	var menuState = MenuState.new(emptyEntity.playerStateStack, emptyEntity.entityUI.playerPanel)
	emptyEntity.playerStateStack.addState(menuState)

func newPlayerJoined(info: PlayerInfo):
	worldRoster.addNewEntity(info, overworldUI.playerUIRoster[info.playerNumber - 1])
