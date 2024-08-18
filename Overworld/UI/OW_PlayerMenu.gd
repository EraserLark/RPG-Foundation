extends MenuSystem
class_name PlayerPanel_World

##Children References
@onready var marginContainer:= $MarginContainer
@onready var initialMenu:= $MarginContainer/InitialMenu
@onready var menuList:= $MarginContainer/InitialMenu/ItemList
@onready var subMenuNodes:= $MarginContainer/Submenus

##Parent References
var owManager: OverworldManager
#var player: OW_Player	#unused?

##Non export vars
var playerInfo: PlayerInfo
var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	menus = subMenuNodes.get_children()
	for menu in menus:
		menu.menuManager = self
	
	initialMenu.menuManager = self
	
	audioPlayer = $AudioStreamPlayer
	
	playerInfo = PlayerRoster.roster[0]
	subMenuNodes.get_child(0).initMenu(playerInfo.itemList)
	
	baseMenu = initialMenu

func initialize(om: OverworldManager):
	owManager = om

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
