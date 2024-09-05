extends StageManager
class_name OverworldManager

##Children references
@onready var overworldWorld:= $World
#@onready var worldRoster:= $WorldRoster
#@onready var overworldUI:= $CanvasLayer/OW_UI
@onready var musicPlayer:= $World/AudioStreamPlayer
@onready var cutsceneManager:= $CutsceneManager

##Parent references
#None

##Non export vars
#var playerEntities: Array[PlayerEntity]

func _ready():
	print("Overworld Ready Start")
	super()
	
	stageUI = $CanvasLayer/OW_UI
	
	stageUI.initialize(self)
	overworldWorld.initialize(self)
	
	var overworldGameState = GameState_Overworld.new()	#Adds itself to GameStateStack
	
	print("Overworld Ready Finish")
