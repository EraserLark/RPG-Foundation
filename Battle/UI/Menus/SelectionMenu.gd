extends Menu
class_name BattleSelectionMenu

##Children References
@onready var playerPointer:= $PlayerPointer

##Parent references
var battleManager: BattleManager
var playerUI: PlayerUI_Battle
var playerPanel: PlayerPanel_Battle

##Inside vars
var selectedAction : Action
var targetRoster : Array
var currentTarget : Entity
var currentSelection : int

func _ready():
	firstFocus = self

func initialize(bm: BattleManager, pui: PlayerUI_Battle):
	battleManager = bm
	playerUI = pui
	playerPanel = playerUI.playerPanel

func OpenMenu():
	super()
	selectedAction = playerPanel.currentSelectedAction
	selectedAction.setupTargetOptions()
	targetRoster = selectedAction.targetOptions
	
	currentSelection = 0
	moveCursor(currentSelection)
	
	playerPointer.set_visible(true)

func _on_gui_input(event: InputEvent):
	if(event.is_action_pressed("ui_accept")):
		confirmSelection()
	elif(event.is_action_pressed("ui_right")):
		currentSelection += 1
		currentSelection %= targetRoster.size()
		moveCursor(currentSelection)
	elif(event.is_action_pressed("ui_left")):
		currentSelection -= 1
		currentSelection %= targetRoster.size()
		moveCursor(currentSelection)

func confirmSelection():
	selectedAction.target = currentTarget
	playerPanel.actionTargetSelected()

func CloseMenu():
	playerPointer.visible = false
	super()

func moveCursor(selection : int):
	currentTarget = targetRoster[selection]
	var targetPos = currentTarget.actor.position
	
	playerPointer.moveToPosition(targetPos)
