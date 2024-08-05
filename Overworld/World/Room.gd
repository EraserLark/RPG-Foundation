extends Node2D
class_name Room

@onready var tileMap:= $TileMap
@onready var castList:= $CastList
@onready var passages:= $Passages
@onready var camera:= $Camera2D

var world
var overworldManager
var bgMusicPlayer
var cutsceneManager

var playerSpawnPort: int

func _ready():
	world = get_parent()
	overworldManager = world.get_parent()
	
	bgMusicPlayer = world.music
	cutsceneManager = world.csManager

func exitRoom(newRoomPath: String, port: int):
	#world.onRoomExit(newRoomPath, port)
	var transition = TransitionState.new(StateStack, overworldManager.cutsceneManager, world, newRoomPath, port)
	StateStack.addState(transition)
