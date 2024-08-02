extends Node2D

@onready var music:= $AudioStreamPlayer
@onready var csManager:= $CutsceneManager
@onready var currentRoom:= $Room

func pauseWorld():
	music.stream_paused = true

func resumeWorld():
	music.stream_paused = false

func onRoomExit(newRoomPath: String):
	#Deload current room
	currentRoom.queue_free()
	#Load new room
	var newRoom = load(newRoomPath)
	var inst = newRoom.instantiate()
	add_child(inst)
