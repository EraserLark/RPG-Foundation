extends Node2D
class_name MinigameFoundation

#var battleManager: BattleManager
var playerNumber: int
var input: DeviceInput
var inputDir: Vector2
var minigameState
var successPercent := 0
var stageWidth
@onready var timer:= $Timer
@onready var progressBar:= $TextureRect

#func _init(player: PlayerEntity):
	#minigameState = MinigameState.new(player.playerStateStack, self)
	#playerNumber = player.rosterNumber
	#input = player.input

func _ready():
	stageWidth = get_viewport_rect().size.x
	timer.start()

func initialize(player: PlayerEntity):
	minigameState = MinigameState.new(player.playerStateStack, self)
	playerNumber = player.rosterNumber
	input = player.input

func update(delta):
	##Get input vector
	inputDir = Vector2.ZERO
	inputDir = input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	##Convert joystick movement to 8 Directions
	if input.is_joypad() && inputDir != Vector2.ZERO:
		inputDir = Helper.convertToEightDir(inputDir)
	
	##Reduce background timer
	var currentTime = timer.wait_time - timer.time_left
	var ratio: float = currentTime / timer.wait_time
	var currentPos = stageWidth * ratio
	progressBar.position.x = currentPos

func handleInput(_event: InputEvent):
	if _event.device != playerNumber:
		return
	
	buttonPressed(_event)

func buttonPressed(_event: InputEvent):
	pass

func physicsUpdate(_delta: float):
	pass

func _on_timer_timeout():
	print(str("Success: ", successPercent, "%"))
	wrapUp()

func wrapUp():
	successPercent = clampi(successPercent, 0, 100)
	var attackBoost := 0
	
	attackBoost = judgeSuccess()
	
	minigameState.atkBoost = attackBoost
	minigameState.resumeState()

func judgeSuccess():
	pass

func endMinigame():
	self.queue_free()
