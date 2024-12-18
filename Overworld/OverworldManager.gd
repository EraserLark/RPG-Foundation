extends StageManager
class_name OverworldManager

##Children references
@onready var overworldWorld:= $World
@onready var musicPlayer:= $World/AudioStreamPlayer
@onready var cutsceneManager:= $CutsceneManager

##Parent references
#None

##Non export vars
#None

func _ready():
	print("Overworld Ready Start")
	super()

	var start_room: Room = find_start_room()

	# wait for all other nodes to be ready, then continue
	await $/root.ready
	
	stageUI = $CanvasLayer/OW_UI
	
	stageUI.initialize(self)
	overworldWorld.initialize(self, start_room)
	cutsceneManager.stageManager = self
	InputManager.initialize()
	
	var overworldGameState = GameState_Overworld.new()	#Adds itself to GameStateStack
	
	print("Overworld Ready Finish")


# Scan the root-level nodes to see if the game has a valid room.
func find_start_room() -> Room:
	for node: Node in $/root.get_children():
		if node is Room:
			return node

	printerr("Game started in a scene that is not a room! Can't initialize global info.")
	return null
