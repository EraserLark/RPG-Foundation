extends MenuSystem
class_name PlayerPanel_World

@onready var initialMenu:= $MarginContainer/InitialMenu
@onready var menuList:= $MarginContainer/InitialMenu/ItemList
@onready var subMenuNodes:= $MarginContainer/Submenus

@onready var overworldManager:= $"../../../.."
@onready var player:= $"../../../../World/CastList/OW_Player"
var playerInfo: PlayerInfo

var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	menus = subMenuNodes.get_children()
	for menu in menus:
		menu.menuManager = self
	
	initialMenu.menuManager = self
	
	playerInfo = player.playerInfo
	subMenuNodes.get_child(0).initMenu(playerInfo.itemList)
	
	baseMenu = initialMenu

func open():
	self.visible = true
	super()

func _on_menu_list_item_activated(menuNum):
	showSubMenu(menus[menuNum])

func itemSelected(index: int):
	pass
	#Need to refactor items to get this to work

func closeMenuSystem():
	self.visible = false
	super()
