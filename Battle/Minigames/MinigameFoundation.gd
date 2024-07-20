extends Node2D
class_name MinigameFoundation

var battleManager
var minigameState
var successPercent := 0
var stageWidth
@onready var timer:= $Timer
@onready var progressBar:= $TextureRect

func _ready():
	minigameState = MinigameState.new(StateStack, self,  battleManager)
	stageWidth = get_viewport_rect().size.x
	timer.start()

func update(delta):
	var currentTime = timer.wait_time - timer.time_left
	var ratio: float = currentTime / timer.wait_time
	var currentPos = stageWidth * ratio
	progressBar.position.x = currentPos

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
	
	attackBoost = guageSuccess()
	
	minigameState.atkBoost = attackBoost
	minigameState.resumeState()

func guageSuccess():
	pass

func endMinigame():
	self.queue_free()
