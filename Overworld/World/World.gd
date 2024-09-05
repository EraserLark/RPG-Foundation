extends Node2D

##Children References
@onready var music:= $AudioStreamPlayer

##Parent references
var owManager: OverworldManager

##Non export vars
var currentRoom

func _ready():
	print("World Ready Start")
	for child in get_children():
		if child is Room:
			currentRoom = child
		else:
			printerr("No room scene")
	print("World Ready Finish")

func initialize(om: OverworldManager):
	owManager = om
	DialogueSystem.updateOWVars(owManager.stageUI, self)	#Update before room. Actors use for spawn flags
	currentRoom.initialize(om)

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
	await currentRoom.tree_exited
	
	#Load new room
	var newRoom = load(newRoomPath)
	var inst = newRoom.instantiate()
	inst.playerSpawnPort = port
	add_child(inst)
	currentRoom = inst
	#Update vars (actors use this for spawn flags)
	DialogueSystem.updateOWVars(owManager.stageUI, self)
	#Initialize new room
	currentRoom.initialize(owManager)
