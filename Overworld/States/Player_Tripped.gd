extends State
class_name Player_Tripped

var playerActor: OW_Player
var input: DeviceInput

var shakeQuota: int
var currentShakes: int = 0

func _init(sStack: StateStack, plyr: OW_Player):
	super(sStack)
	playerActor = plyr
	input = playerActor.playerEntity.input
	
	shakeQuota = randi_range(3, 5)

func enter(_msg:= {}):
	playerActor.animTree.active = false
	playerActor.sprite.frame = 36	#Set to trip frame while other animation plays
	playerActor.animPlayer.play("Shake")

func handleInput(event: InputEvent):
	#if event.device != playerActor.playerEntity.deviceNumber:
		#return
	
	if(event.is_action_pressed("ui_accept")):
		shake()

func shake():
	currentShakes += 1
	if currentShakes >= shakeQuota:
		wakeUp()
	else:
		playerActor.animPlayer.play("Shake")

func shakeAnimDone():
	print("Shake Done!")

func wakeUp():
	playerActor.animPlayer.stop()   #Stop shake animation if playing
	playerActor.animTree.active = true
	playerActor.animState.travel("Idle")
	
	playerActor.faceDirection(Vector2(0, 1))
	exit()

func exit():
	super()
