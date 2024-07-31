extends MenuSystem
class_name PlayerUI_Battle

@onready var actionMenu:= $PlayerMenu/ActionMenu
@onready var attackMenu:= $PlayerMenu/MarginContainer/AttackMenu
@onready var itemMenu:= $PlayerMenu/MarginContainer/ItemMenu
@onready var miscMenu:= $PlayerMenu/MarginContainer/MiscMenu
@onready var stats:= $PlayerMenu/Stats
@onready var playerPointer:= $PlayerPointer
@onready var playerMenu:= $PlayerMenu
@onready var selectionMenu:= $SelectionMenu

@onready var minigameContainer:= $PlayerMenu/MarginContainer/SubViewportContainer
@onready var minigameView:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport
@onready var minigameZone:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport/MinigameZone

var player: PlayerEntity
var battleManager
var currentSelectedAction

func _ready():
	playerMenu.populateVars(self)

func open():
	baseMenu = playerMenu
	super()

func attackSelected(index: int):
	currentSelectedAction = player.attackChosen(index)
	setupSelection(currentSelectedAction)

func actionSelected(index: int):
	currentSelectedAction = player.actionChosen(index)
	setupSelection(currentSelectedAction)

func itemSelected(index: int):
	currentSelectedAction = player.itemChosen(index)
	setupSelection(currentSelectedAction)

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	#CloseActionMenu()
	#showActionMenu(false)
	
	#Change to event, have it enqueued in the promptEQ
	#var promptQueue = battleManager.battleState.battlePM.promptPhase.promptEQ
	#SelectionState.createEvent(promptQueue, battleManager, StateStack, playerPointer, self, selectedAction)
	#var selectionState = SelectionState.new(StateStack, playerPointer, self, battleManager, selectedAction)
	#StateStack.addState(selectionState)
	
	showSubMenu(selectionMenu)
	
	#promptQueue.currentEvent = promptQueue.queue[0]
	#StateStack.resumeCurrentState()

func actionTargetSelected():
	#emit_signal("selectionMade")
	closeMenuSystem()

func changeStatsHealth(remaningHP: int):
	stats.changeHealth(remaningHP)

func showMinigame(case: bool):
	actionMenu.visible = false
	attackMenu.visible = false
	self.visible = case
	playerMenu.visible = case
	minigameContainer.visible = case

func showPlayerMenu(case: bool):
	self.visible = case
	playerMenu.visible = case
	actionMenu.visible = false
