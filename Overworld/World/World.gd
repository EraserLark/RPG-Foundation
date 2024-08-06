extends Node2D

@onready var owManager:= $".."
@onready var music:= $AudioStreamPlayer
@onready var csManager:= $CutsceneManager
@onready var currentRoom:= $FirstRoom

func pauseWorld():
	music.stream_paused = true

func resumeWorld():
	music.stream_paused = false

func onRoomExit(newRoomPath: String, port: int):
	#Deload current room
	var actors = currentRoom.castList.get_children()
	for actor in actors:
		if actor is OW_Player:
			actor.endPlayerActor()
	currentRoom.queue_free()
	#Load new room
	var newRoom = load(newRoomPath)
	var inst = newRoom.instantiate()
	inst.playerSpawnPort = port
	add_child(inst)
	currentRoom = inst
