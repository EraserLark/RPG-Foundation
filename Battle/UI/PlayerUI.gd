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
	get_viewport().set_input_as_handled()
	player.attackChosen(index)
	
	CloseActionMenu()
	showActionMenu(false)
	#Whatever comes next for starting the attack. Selecting target.
	var selectionState = SelectionState.new(StateStack, playerPointer, self, battleManager)
	StateStack.addState(selectionState)

func attackTargetSelected():
	emit_signal("selectionMade")

func actionSelected(index : int):
	#Whatever comes next for starting the attack. Selecting target.
	#...
	
	CloseActionMenu()
	showActionMenu(false)
	
	player.actionChosen(index)
	emit_signal("selectionMade")

func itemSelected(index : int):
	CloseActionMenu()
	showActionMenu(false)
	
	player.itemChosen(index)
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
