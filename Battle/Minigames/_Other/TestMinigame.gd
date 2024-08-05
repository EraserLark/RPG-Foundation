extends MinigameFoundation
class_name Minigame_Test

@onready var lightSprites:= $Lights
var lights:= 4
var litCount:= 0
var onSprite = preload("res://Art/Full.png")

func _ready():
	super()

func update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		newLight()
	
	super(delta)

func newLight():
	if(litCount >= lightSprites.get_child_count()):
		return
	
	lightSprites.get_child(litCount).texture = onSprite
	litCount += 1
	successPercent += 25
	
func wrapUp():
	super()

func guageSuccess():
	if(successPercent == 100):
		return 1
	elif(successPercent >= 50):
		return 0
	elif(successPercent < 50):
		return -999

func endMinigame():
	self.queue_free()
