extends PlayerPanel
class_name PlayerPanel_World

##Children References
@onready var marginContainer:= $MarginContainer
@onready var initialMenu:= $MarginContainer/InitialMenu
#@onready var menuList:= $MarginContainer/InitialMenu/ItemList
@onready var subMenuNodes:= $MarginContainer/Submenus
#@onready var panelAnchorNodes:= $PanelAnchors

##Parent References
var owManager: OverworldManager
#var player: OW_Player	#unused?
#var player: PlayerInfo
var playerEntity: OWEntity_Player

##Non export vars
var playerInfo: PlayerInfo
var panelAnchors: Array
var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	menus = subMenuNodes.get_children()
	for menu in menus:
		menu.menuManager = self
	
	initialMenu.menuManager = self
	
	audioPlayer = $AudioStreamPlayer
	panelAnchors = panelAnchorNodes.get_children()
	
	playerInfo = PlayerRoster.roster[0]
	subMenuNodes.get_child(0).initMenu(playerInfo)
	
	baseMenu = initialMenu

func initialize(om: OverworldManager, pe: OWEntity_Player):
	owManager = om
	#player = PlayerRoster.roster[0]		#Change when multiplayer
	playerEntity = pe

func refreshMenu():
	initialMenu.setHP()

func open():
	refreshMenu()
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
