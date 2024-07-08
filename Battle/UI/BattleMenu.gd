extends Panel

@onready var actionMenu := $ActionMenu
@onready var attackMenu := $AttackMenu
@onready var itemMenu := $ItemMenu
@onready var miscMenu := $MiscMenu
@onready var stats := $Stats

var player

var prevFocused : Control = null
var menus : Array[Menu]
var openMenu : Menu = null

signal selectionMade

func _ready():
	for node in get_children():
		node.playerUI = self
	
	#Populate menus array
	menus += [attackMenu, itemMenu, miscMenu]

func showActionMenu(condition : bool):
	visible = condition
	
	if(condition):
		actionMenu.attackButton.grab_focus()

func attackSelected(index : int):
	#Whatever comes next for starting the attack. Selecting target.
	#...
	
	CloseActionMenu()
	showActionMenu(false)
	
	player.attackChosen(index)
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
