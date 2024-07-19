extends Node2D

var battleManager
var minigameState
var successPercent := 0
var stageWidth

var lights:= 4
var litCount:= 0

@onready var timer:= $Timer
@onready var progressBar:= $TextureRect
@onready var lightSprites:= $Lights
var onSprite = preload("res://Art/Full.png")

func _ready():
	minigameState = MinigameState.new(StateStack, self,  battleManager)
	stageWidth = get_viewport_rect().size.x
	timer.start()

func update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		newLight()
	
	var currentTime = timer.wait_time - timer.time_left
	var ratio: float = currentTime / timer.wait_time
	var currentPos = stageWidth * ratio
	progressBar.position.x = currentPos

func newLight():
	if(litCount >= lightSprites.get_child_count()):
		return
	
	lightSprites.get_child(litCount).texture = onSprite
	litCount += 1
	successPercent += 25

func handleInput(_event : InputEvent):
	pass

func physicsUpdate(_delta : float):
	pass

func _on_timer_timeout():
	print(str("Success: ", successPercent, "%"))
	wrapUp()
	
func wrapUp():
	successPercent = clampi(successPercent, 0, 100)
	var attackBoost := 0
	
	if(successPercent == 100):
		attackBoost = 1
	elif(successPercent >= 50):
		attackBoost = 0
	elif(successPercent < 50):
		attackBoost = -999
	
	minigameState.atkBoost = attackBoost
	minigameState.resumeState()

func endMinigame():
	self.queue_free()
