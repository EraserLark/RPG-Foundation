@tool
extends Node2D
class_name Room

##Scene path
var battleScenePath = "res://Battle/battle.tscn"

##Children references
@onready var tileLayers:= $TileLayers
@onready var castList:= $CastList
@onready var passages:= $Passages
@onready var camera:= $Camera2D
@onready var cameraMarks:= $CameraMarks
@onready var roomPhantomCam:= $CameraMarks/PhantomCamera2D
@onready var cutsceneMarks:= $CutsceneMarks
@onready var navigationMaps:= $NavigationMaps
@onready var animPlayer:= $AnimationPlayer

##Parent references
var world
var owManager: OverworldManager
var bgMusicPlayer
var cutsceneManager

##Export vars
@export var roomData: RoomData
@export var enemyRoster: Array[EnemyInfo]

##Non export vars
var playerSpawnPort: int

func _exit_tree():
	populateGlobalVars() 

func _ready():
	print("Room Ready Start")
	print("Room Ready Finish")

func initialize(om: OverworldManager):
	owManager = om
	world = owManager.overworldWorld
	
	bgMusicPlayer = world.music
	cutsceneManager = owManager.cutsceneManager
	
	camera.initialize(om, self)
	castList.initialize(om, self)
	passages.initialize(om, self)
	
	populateGlobalVars()
	
	for actor in castList.get_children():
		if actor is OW_Actor:
			actor.checkSpawnFlags()

func populateGlobalVars():
	if roomData != null:
		roomData.clearData()
		roomData.room = self
		
		var roomFlagList = FlagManager.flags["World"]["Zone1"]["FirstRoom"]
		
		for child in $CastList.get_children():
			roomData.castList.append(child.name)
			if(child is OW_Actor):
				roomFlagList["CastList"][child.name] = child.npcResource.characterFlags
		for child in $Passages.get_children():
			roomData.passageList.append(child.name)
		for child in $CutsceneMarks.get_children():
			roomData.cutsceneMarks.append(child.name)
		
		print(str("Room flag list: ", roomFlagList))

func startBattle(battleData: Array[EnemyInfo] = []):
	world.pauseWorld()
	
	##If no preset enemies, choose randomly from catalog
	if(battleData.is_empty()):
		var randInt = randi_range(1, 3)
		for i in randInt:
			battleData.append(enemyRoster.pick_random())
	
	var inst = BattleManager.initBattle(battleData)
	get_node("/root").add_child(inst)

func exitRoom(newRoomPath: String, port: int):
	#world.onRoomExit(newRoomPath, port)
	var transition = TransitionState.new(GameStateStack.stack, owManager.cutsceneManager, world, newRoomPath, port)
	GameStateStack.stack.addState(transition)
