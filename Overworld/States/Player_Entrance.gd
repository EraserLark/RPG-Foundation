extends State
class_name Player_Entrance

var playerActor: OW_Player
var input: DeviceInput

var landingPosition: Vector2
var startingPosition: Vector2
var entranceBeam = preload("res://Overworld/EntranceBeam.tscn")
var beamInstance
var descentTween
var t = 0.0

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	input = playerActor.playerEntity.input
	
	landingPosition = playerActor.position
	startingPosition = landingPosition + Vector2(0, -1000)

func handleInput(event : InputEvent):
	if event.device != playerActor.playerEntity.deviceNumber:
		return
	
	if(event.is_action_pressed("ui_accept")):
		#Player plummets to ground. Enter Tripped state upon exit
		pass

func enter(_msg:= {}):
	#Start player off screen, disable collision
	#playerActor.position += Vector2(0, -200)
	playerActor.collisionShape.disabled = true
	#Spawn Entrance Beam
	beamInstance = entranceBeam.instantiate()
	playerActor.currentRoom.add_child(beamInstance)
	#Start descent tween
	descentTween = playerActor.get_tree().create_tween()
	descentTween.finished.connect(exit)
	descentTween.tween_property(playerActor, "position", landingPosition, 2).set_trans(Tween.TRANS_CUBIC)

func update(_delta: float):
	#Player floats down, spinning in circles
	#t += _delta
	#playerActor.position = startingPosition.slerp(landingPosition, t)
	#if t > 1.0:
		#exit()
	pass

func exit():
	#Kill tween
	descentTween.kill()
	#Re enable player collision
	playerActor.collisionShape.disabled = false
	#Close entrance beam
	beamInstance.CloseBeam()
	super()
