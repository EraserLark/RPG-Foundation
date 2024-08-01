extends MenuSystem
class_name PlayerUI_OW

@onready var initialMenu:= $MarginContainer/InitialMenu
@onready var menuList:= $MarginContainer/InitialMenu/ItemList
@onready var subMenuNodes:= $MarginContainer/Submenus

@onready var overworldManager:= $"../../.."
var player
var playerInfo: PlayerInfo

var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	menus = subMenuNodes.get_children()
	for menu in menus:
		menu.menuManager = self
	
	initialMenu.menuManager = self
	
	baseMenu = initialMenu

func open():
	self.visible = true
	super()

func _on_menu_list_item_activated(menuNum):
	showSubMenu(menus[menuNum])

func closeMenuSystem():
	self.visible = false
	super()
