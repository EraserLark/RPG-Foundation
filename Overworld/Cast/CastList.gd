extends Node2D
class_name CastList

##Preload vars
var actorScene:= preload("res://Overworld/Cast/OW_Player.tscn")

##Children references
#None

##Parent references
var owManager: OverworldManager
var room: Room
var passages: PassagesManager
var camera: Camera2D

##Non export vars
var playerActors: Array[OW_Player]

##Signals
signal actor_speaking(name, message)

func initialize(om: OverworldManager, rm: Room):
	owManager = om
	room = rm
	passages = room.passages
	camera = room.camera
	
	#for playerInfo in PlayerRoster.roster:
		#addActor(playerInfo, camera.get_screen_center_position())
	
	for entity in owManager.playerEntities:
		addActor(entity, camera.get_screen_center_position())
	
	for child in get_children():
		if child is not OW_Player:
			child.initialize(owManager, room)

func addActor(playerEntity: OWEntity_Player, pos: Vector2):
	#Instance actor, set up data
	var playerActor = actorScene.instantiate()
	playerActor.setPlayerInfo(playerEntity.entityInfo)
	self.add_child(playerActor)
	playerActor.initialize(playerEntity, room)
	
	#Create Player Active state to start actor off with
	var pState = Player_Active.new(StateStack, playerActor)
	playerEntity.playerState = pState
	StateStack.addState(pState)
	
	#Add actor to lists
	playerActors.append(playerActor)	#local list
	playerEntity.entityActor = playerActor
	#playerEntity.entityInfo.setActor(playerActor)	#playerInfo gets a reference
	
	#Determine where to spawn the player
	if(room.playerSpawnPort == null):
		playerActor.position = Vector2.ZERO
	else:
		var port = room.playerSpawnPort
		playerActor.position = passages.getSpawnPoint(port)
		playerActor.faceDirection(passages.getSpawnDir(port))
	
	camera.setTarget(playerActor)

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)
