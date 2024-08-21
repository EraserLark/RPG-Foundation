@tool
extends Node2D
class_name Room

##Children references
@onready var tileLayers:= $TileLayers
@onready var castList:= $CastList
@onready var passages:= $Passages
@onready var camera:= $Camera2D
@onready var cutsceneMarks:= $CutsceneMarks
@onready var navigationMaps:= $NavigationMaps

##Parent references
var world
var owManager: OverworldManager
var bgMusicPlayer
var cutsceneManager

##Export vars
@export var roomData: RoomData

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

func exitRoom(newRoomPath: String, port: int):
	#world.onRoomExit(newRoomPath, port)
	var transition = TransitionState.new(StateStack, owManager.cutsceneManager, world, newRoomPath, port)
	StateStack.addState(transition)
