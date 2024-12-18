extends MinigameFoundation
class_name Minigame_Test

@onready var lightSprites:= $Lights
var lights:= 4
var litCount:= 0
var onSprite = preload("res://Art/Full.png")

func _ready():
	super()

func update(_delta: float, deviceNum: int):
	super(_delta, deviceNum)

##Parent class filters out other player input
func buttonPressed(_event : InputEvent):
	if _event.is_action_pressed("ui_accept"):
		newLight()

func newLight():
	if(litCount >= lightSprites.get_child_count()):
		return
	
	lightSprites.get_child(litCount).texture = onSprite
	litCount += 1
	successPercent += 25
	
func wrapUp():
	super()

func judgeSuccess():
	if(successPercent == 100):
		return 1
	elif(successPercent >= 50):
		return 0
	elif(successPercent < 50):
		return -999

func endMinigame():
	self.queue_free()
