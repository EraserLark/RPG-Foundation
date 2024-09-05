extends ManualMenu
class_name TargetSelectionMenu

##Children References
@onready var playerPointer:= $PlayerPointer

##Parent references
var battleManager: BattleManager
var playerUI: PlayerUI_Battle
var playerPanel: PlayerPanel_Battle

##Inside vars
var selectedAction: Action
var targetRoster: Array
var currentTarget: Entity
var currentSelection: int

##ManualMenu vars
@export var initialTimer: Timer
@export var echoTimer: Timer
var listSize: int

##Base Manual Menu
var focusButton: Button
#var arraySize: int
var inputTimerStarted:= false
var inputTimerFinished:= false
var initialInput:= true
var heldActionName: String
var currentTimer: Timer

func initialize(bm: BattleManager, pui: PlayerUI_Battle):
	battleManager = bm
	playerUI = pui
	playerPanel = playerUI.playerPanel
	
	menuManager = playerPanel
	
	playerPointer.set_self_modulate(PlayerRoster.rosterColors[menuManager.player.rosterNumber])

func OpenMenu():
	super()
	selectedAction = playerPanel.currentSelectedAction
	selectedAction.setupTargetOptions()
	targetRoster = selectedAction.targetOptions
	
	currentSelection = 0
	moveCursor(currentSelection)
	
	playerPointer.set_visible(true)

func runMenuUpdate(input: DeviceInput):
	if input.is_action_pressed("ui_right"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_right"
			
			currentSelection += 1
			currentSelection %= listSize
			moveCursor(currentSelection)
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection += 1
			currentSelection %= listSize
			moveCursor(currentSelection)
			
			currentTimer = echoTimer
			currentTimer.start()
	elif input.is_action_pressed("ui_left"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_left"
			
			currentSelection -= 1
			currentSelection %= listSize
			moveCursor(currentSelection)
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection -= 1
			currentSelection %= listSize
			moveCursor(currentSelection)
			
			currentTimer = echoTimer
			currentTimer.start()
	elif heldActionName != "":
		if input.is_action_just_released(heldActionName):
			currentTimer.stop()
			#heldActionName = ""
			initialInput = true

func activateOption():
	selectedAction.target = currentTarget
	playerPanel.actionTargetSelected()

func CloseMenu():
	playerPointer.visible = false
	super()

func moveCursor(selection : int):
	currentTarget = targetRoster[selection]
	var targetPos = currentTarget.actor.position
	#Move arrow down to accomodate multiple player arrows
	targetPos += Vector2(0, 16 * menuManager.player.rosterNumber)
	
	playerPointer.moveToPosition(targetPos)

func setPrevFocus():
	#Store prevFocus as int here
	prevFocus = currentSelection

func grabPrevFocus():
	currentSelection = prevFocus

func _on_initial_timer_timeout():
	inputTimerFinished = true

func _on_echo_timer_timeout():
	inputTimerFinished = true
