extends State
class_name Player_Entrance

var playerActor: OW_Player
var input: DeviceInput

var landingPosition: Vector2
var startingPosition: Vector2
var beamScene = preload("res://Overworld/EntranceBeam.tscn")
var fireScene = preload("res://Overworld/OrbitEntry.tscn")
var craterScene = preload("res://Overworld/ExplosionCrater.tscn")
var beamInstance
var fireInstance
var descentTween
var roomPhantomCam
var t = 0.0
var turbo = false
var tweenLength = 2

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	input = playerActor.playerEntity.input
	
	landingPosition = playerActor.position
	startingPosition = landingPosition + Vector2(0, -1000)
	
	roomPhantomCam = playerActor.currentRoom.roomPhantomCam
	roomPhantomCam.erase_follow_targets(playerActor)

func handleInput(event : InputEvent):
	if event.device != playerActor.playerEntity.deviceNumber:
		return
	
	if(event.is_action_pressed("ui_accept")):
		if !turbo:
			turbo = true
			
			fireInstance = fireScene.instantiate()
			playerActor.add_child(fireInstance)
			
			var timeRan = descentTween.get_total_elapsed_time()
			descentTween.disconnect("finished", postLanding)
			descentTween.kill()
			
			descentTween = playerActor.get_tree().create_tween()
			descentTween.finished.connect(postLanding)
			descentTween.tween_property(playerActor, "position", landingPosition, (tweenLength - timeRan)).set_trans(Tween.TRANS_LINEAR)
			descentTween.set_speed_scale(4)

func enter(_msg:= {}):
	#Start player off screen, disable collision
	playerActor.position = startingPosition
	playerActor.collisionShape.disabled = true
	playerActor.animState.travel("Idle")	#Needed to get spin code working
	#Spawn Entrance Beam
	beamInstance = beamScene.instantiate()
	playerActor.currentRoom.add_child(beamInstance)
	beamInstance.position = landingPosition
	#Focus cam
	roomPhantomCam.append_follow_targets(beamInstance)
	#Start descent tween
	descentTween = playerActor.get_tree().create_tween()
	descentTween.finished.connect(postLanding)
	descentTween.tween_property(playerActor, "position", landingPosition, tweenLength).set_trans(Tween.TRANS_CUBIC)

func physicsUpdate(_delta: float):
	#Player floats down, spinning in circles
	t += _delta * 13
	var dirVector = Vector2(cos(t), sin(t)).normalized()
	print(dirVector)
	
	#Simplified playerActor.faceDirection() (No dance detection)
	playerActor.interactRay.target_position = dirVector * playerActor.rayLength;
	playerActor.animTree.set("parameters/Idle/blend_position", dirVector)

func postLanding():
	descentTween.kill()
	playerActor.collisionShape.disabled = false
	beamInstance.CloseBeam()
	if fireInstance:
		fireInstance.queue_free()
	#Switch cam focus from beam to player
	roomPhantomCam.append_follow_targets(playerActor)
	roomPhantomCam.erase_follow_targets(beamInstance)
	
	if turbo:
		var craterInstance = craterScene.instantiate()
		playerActor.currentRoom.add_child(craterInstance)
		craterInstance.position = landingPosition
		
		var playerStateStack = playerActor.playerEntity.playerStateStack
		var playerTripped = Player_Tripped.new(playerStateStack, playerActor)
		playerStateStack.addState(playerTripped)
	else:
		exit()

func resumeState():
	exit()

func exit():
	super()
