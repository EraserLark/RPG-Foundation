extends Control

@onready var actionMenu := $PlayerMenu/ActionMenu
@onready var attackMenu := $PlayerMenu/AttackMenu
@onready var itemMenu := $PlayerMenu/ItemMenu
@onready var miscMenu := $PlayerMenu/MiscMenu
@onready var stats := $PlayerMenu/Stats
@onready var playerPointer := $PlayerPointer
@onready var playerMenu := $PlayerMenu

var player
var battleManager

var prevFocused : Control = null
var menus : Array[Menu]
var openMenu : Menu = null

signal selectionMade

func _ready():
	playerMenu.populateVars(self)
	#Populate menus array
	menus += [attackMenu, itemMenu, miscMenu]

func showActionMenu(condition : bool):
	playerMenu.visible = condition
	
	if(condition):
		actionMenu.attackButton.grab_focus()

func attackSelected(index : int):
	var selectedAction = player.attackChosen(index)
	
	setupSelection(selectedAction)

func actionSelected(index : int):
	var selectedAction = player.actionChosen(index)
	setupSelection(selectedAction)

func itemSelected(index : int):
	var selectedAction = player.itemChosen(index)
	setupSelection(selectedAction)

func setupSelection(selectedAction : Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	CloseActionMenu()
	showActionMenu(false)
	
	var selectionState = SelectionState.new(StateStack, playerPointer, self, battleManager, selectedAction)
	StateStack.addState(selectionState)

func actionTargetSelected():
	emit_signal("selectionMade")

func OpenActionMenu(menuNum : int):
	openMenu = menus[menuNum]
	prevFocused = get_viewport().gui_get_focus_owner()
	openMenu.OpenMenu()

func CloseActionMenu():
	openMenu.CloseMenu()
	openMenu = null
	prevFocused.grab_focus()

func changeStatsHealth(remaningHP : int):
	stats.changeHealth(remaningHP)
