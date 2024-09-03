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
#var playerEntity: OWEntity_Player
var playerNum: int

##Non export vars
var playerInfo: PlayerInfo
var panelAnchors: Array
var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	profileMenu.menuManager = self
	initialMenu.menuManager = self
	
	menus = subMenuNodes.get_children()
	for menu in menus:
		menu.menuManager = self
	
	audioPlayer = $AudioStreamPlayer
	panelAnchors = panelAnchorNodes.get_children()
	
	baseMenu = initialMenu

func initialize(om: OverworldManager, pe: PlayerEntity):
	owManager = om
	#player = PlayerRoster.roster[0]		#Change when multiplayer
	playerEntity = pe	#Should get set after player chooses profile
	
	playerInfo = playerEntity.entityInfo
	initialMenu.initMenu()
	subMenuNodes.get_child(0).initMenu(playerInfo)

func refreshMenu():
	initialMenu.setHP()

func open(sStack: StateStack):
	if(playerInfo != null):
		refreshMenu()
	self.visible = true
	super(sStack)

func showInitialMenuSelection(menuNum):
	showSubMenu(menus[menuNum])

func itemSelected(index: int):
	pass
	#Need to refactor items to get this to work

func closeMenuSystem():
	self.visible = false
	super()
