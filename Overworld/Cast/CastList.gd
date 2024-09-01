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
var phantomCam: PhantomCamera2D

##Non export vars
var playerActors: Array[OW_Player]

##Signals
signal actor_speaking(name, message)

func initialize(om: OverworldManager, rm: Room):
	owManager = om
	room = rm
	passages = room.passages
	camera = room.camera
	phantomCam = room.roomPhantomCam
	
	#for playerInfo in PlayerRoster.roster:
		#addActor(playerInfo, camera.get_screen_center_position())
	
	for entity in owManager.playerEntities:
		addActor(entity, camera.get_screen_center_position())
	
	for child in get_children():
		if child is not OW_Player:
			child.initialize(owManager, room)

func addActor(playerEntity: OWEntity_Player, pos: Vector2 = Vector2.ZERO):
	#Instance actor, set up data
	var playerActor = actorScene.instantiate()
	#playerActor.setPlayerInfo(playerEntity.entityInfo)
	self.add_child(playerActor)
	playerActor.initialize(playerEntity, room)
	
	#Create Player Active state to start actor off with
	var pState = Player_Active.new(playerEntity.playerStateStack, playerActor)
	playerEntity.playerState = pState
	playerEntity.playerStateStack.addState(pState)
	
	#Add actor to lists
	playerActors.append(playerActor)	#local list
	playerActors.sort_custom(sortPlayerActors)
	playerEntity.entityActor = playerActor
	#playerEntity.entityInfo.setActor(playerActor)	#playerInfo gets a reference
	
	#Determine where to spawn the player
	if(room.playerSpawnPort == null):
		playerActor.position = Vector2.ZERO
	else:
		var port = room.playerSpawnPort
		playerActor.position = passages.getSpawnPoint(port)
		playerActor.faceDirection(passages.getSpawnDir(port))
	
	#camera.setTarget(playerActor)
	phantomCam.append_follow_targets(playerActor)

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)

func removeActor(actor: OWEntity_Player):
	playerActors.erase(actor)
	playerActors.sort_custom(sortPlayerActors)
	actor.queue_free()

##Used for sort_custom
func sortPlayerActors(a, b):
	if a.playerEntity == null or b.playerEntity==null:
		return false
	if a.playerEntity.deviceNumber < b.playerEntity.deviceNumber:
		return true
	return false
