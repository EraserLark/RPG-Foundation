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
	
	for entity in PlayerRoster.getActiveRoster():	#Ignore empty entities
		addActor(entity, camera.get_screen_center_position())
	
	for child in get_children():
		if child is not OW_Player:
			child.initialize(owManager, room)

func addActor(playerEntity: PlayerEntity, pos: Vector2 = Vector2.ZERO):
	#Instance actor, set up data
	var playerActor = actorScene.instantiate()
	#playerActor.setPlayerInfo(playerEntity.entityInfo)
	self.add_child(playerActor)
	playerActor.initialize(playerEntity, room)
	
	#Determine where to spawn the player	
	##First time spawning
	if playerEntity.worldActor == null:
		#First actor
		if playerActors.size() <= 0:
			playerActor.position = Vector2.ZERO
		else:
			playerActor.position = playerActors[0].scanForSpawn()
	##Entering Room
	else:
		playerEntity.playerActiveState.playerActor = playerActor
		
		var port = room.playerSpawnPort
		var portPos = passages.getSpawnPoint(port)
		playerActor.position = portPos
		var spawnDir = passages.getSpawnDir(port)
		playerActor.faceDirection(spawnDir)
		
		##Spawn players out in a line (roughly)
		if int(spawnDir.x) != 0:
			playerActor.position += Vector2(0, randi_range(-64, 64))
		elif int(spawnDir.y) != 0:
			playerActor.position += Vector2(randi_range(-64, 64), 0)
	
	#Add actor to lists
	playerActors.append(playerActor)	#local list
	playerActors.sort_custom(sortPlayerActors)
	playerEntity.worldActor = playerActor	#Need this below spawn determination (code above)
	
	#Camera
	phantomCam.append_follow_targets(playerActor)

func actorSpeak(actorName, actorMessage):
	emit_signal("actor_speaking", actorName, actorMessage)

func removeActor(actor: OW_Player):
	playerActors.erase(actor)
	phantomCam.erase_follow_targets(actor)
	playerActors.sort_custom(sortPlayerActors)
	actor.queue_free()

##Used for sort_custom
func sortPlayerActors(a, b):
	if a.playerEntity == null or b.playerEntity==null:
		return false
	if a.playerEntity.deviceNumber < b.playerEntity.deviceNumber:
		return true
	return false
