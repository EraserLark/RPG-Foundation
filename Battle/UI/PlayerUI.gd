extends Control

@onready var actionMenu:= $PlayerMenu/ActionMenu
@onready var attackMenu:= $PlayerMenu/AttackMenu
@onready var itemMenu:= $PlayerMenu/ItemMenu
@onready var miscMenu:= $PlayerMenu/MiscMenu
@onready var stats:= $PlayerMenu/Stats
@onready var playerPointer:= $PlayerPointer
@onready var playerMenu:= $PlayerMenu
@onready var minigameView:= $PlayerMenu/SubViewportContainer

var player
var battleManager

var prevFocused: Control = null
var menus: Array[Menu]
var openMenu: Menu = null

signal selectionMade

func _ready():
	playerMenu.populateVars(self)
	#Populate menus array
	menus += [attackMenu, itemMenu, miscMenu]
	
	showActionMenu(false)

func showActionMenu(condition: bool):
	playerMenu.visible = condition
	actionMenu.visible = condition
	minigameView.visible = false
	
	if(condition):
		actionMenu.attackButton.grab_focus()

func attackSelected(index: int):
	var selectedAction = player.attackChosen(index)
	
	setupSelection(selectedAction)

func actionSelected(index: int):
	var selectedAction = player.actionChosen(index)
	setupSelection(selectedAction)

func itemSelected(index: int):
	var selectedAction = player.itemChosen(index)
	setupSelection(selectedAction)

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	CloseActionMenu()
	showActionMenu(false)
	
	#Change to event, have it enqueued in the promptEQ
	var promptQueue = battleManager.battleState.battleEQ.currentEvent.promptEQ
	SelectionState.createEvent(promptQueue, battleManager, StateStack, playerPointer, self, selectedAction)
	#StateStack.addState(selectionState)
	
	promptQueue.currentEvent = promptQueue.queue[0]
	StateStack.resumeCurrentState()

func actionTargetSelected():
	emit_signal("selectionMade")

func OpenActionMenu(menuNum: int):
	openMenu = menus[menuNum]
	prevFocused = get_viewport().gui_get_focus_owner()
	openMenu.OpenMenu()

func CloseActionMenu():
	openMenu.CloseMenu()
	openMenu = null
	prevFocused.grab_focus()

func changeStatsHealth(remaningHP: int):
	stats.changeHealth(remaningHP)

func showMinigame(case: bool):
	actionMenu.visible = false
	self.visible = case
	playerMenu.visible = case
	minigameView.visible = case
