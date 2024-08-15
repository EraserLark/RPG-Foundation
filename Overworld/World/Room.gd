@tool
extends Node2D
class_name Room

@onready var tileMap:= $TileMap
@onready var castList:= $CastList
@onready var passages:= $Passages
@onready var camera:= $Camera2D
@onready var cutsceneMarks:= $CutsceneMarks

var world
var overworldManager
var bgMusicPlayer
var cutsceneManager

var playerSpawnPort: int

@export var roomData: RoomData

func _exit_tree():
	if roomData != null:
		roomData.clearData()
		roomData.room = self
		#roomData.castList = $CastList.get_children() as Array[OW_Actor]
		#for child in $CastList.get_children():
			#roomData.castList.append(child.name)
		for child in $CastList.get_children():
			roomData.castList.append(child.name)
		for child in $Passages.get_children():
			roomData.passageList.append(child.name)
		for child in $CutsceneMarks.get_children():
			roomData.cutsceneMarks.append(child.name)
		print("Tree exited")

func _ready():
	world = get_parent()
	overworldManager = world.get_parent()
	
	bgMusicPlayer = world.music
	cutsceneManager = world.csManager

func exitRoom(newRoomPath: String, port: int):
	#world.onRoomExit(newRoomPath, port)
	var transition = TransitionState.new(StateStack, overworldManager.cutsceneManager, world, newRoomPath, port)
	StateStack.addState(transition)
