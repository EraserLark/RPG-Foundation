extends StageManager
class_name OverworldManager

##Children references
@onready var overworldWorld:= $World
#@onready var worldRoster:= $WorldRoster
@onready var overworldUI:= $CanvasLayer/OW_UI
@onready var musicPlayer:= $World/AudioStreamPlayer
@onready var cutsceneManager:= $CutsceneManager

##Parent references
#None

##Non export vars
#var playerEntities: Array[PlayerEntity]

func _ready():
	print("Overworld Ready Start")
	InputManager.newPlayerJoined.connect(newControllerJoined)
	
	overworldUI.initialize(self)
	overworldWorld.initialize(self)
	
	var overworldGameState = GameState_Overworld.new()	#Adds itself to GameStateStack
	
	print("Overworld Ready Finish")

func newControllerJoined(joypadNum: int):
	var emptyEntity = PlayerRoster.addEmptySlot(self, joypadNum)
	
	var manualMenuState = ManualMenu_State.new(emptyEntity.playerStateStack, emptyEntity.input, emptyEntity.worldUI.playerPanel)
	emptyEntity.playerStateStack.addState(manualMenuState)
