extends PlayerPanel
class_name PlayerPanel_Battle

##Children references
@onready var stats:= $Stats
@onready var playerMenu:= $PlayerMenu
@onready var minigameContainer:= $PlayerMenu/MarginContainer/SubViewportContainer
@onready var minigameView:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport
@onready var minigameZone:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport/MinigameZone
#@onready var panelAnchorNodes:= $PanelAnchors

##Parent/Outside references
var battleManager: BattleManager
var playerUI: PlayerUI_Battle
var selectionMenu: BattleSelectionMenu
var playerPointer: Cursor
var player: BattleEntity_Player

##Inside vars
var currentSelectedAction
var isActionItem:= false
var itemIndex
var panelAnchors: Array

func _ready():
	audioPlayer = $AudioStreamPlayer
	panelAnchors = $PanelAnchors.get_children()

func initialize(bm: BattleManager, pui: PlayerUI_Battle, pe: BattleEntity_Player):
	battleManager = bm
	playerUI = pui
	selectionMenu = playerUI.selectionMenu
	playerPointer = selectionMenu.playerPointer
	player = pe
	
	stats.initialize(player.entityInfo)
	playerMenu.initialize(self)
	
	#stats.setInitialHealth()

func open():
	baseMenu = playerMenu
	player = playerUI.player
	super()

func attackSelected(index: int):
	currentSelectedAction = player.attackChosen(index)
	isActionItem = false
	setupSelection(currentSelectedAction)

func itemSelected(index: int):
	currentSelectedAction = player.itemChosen(index)
	isActionItem = true
	itemIndex = index
	setupSelection(currentSelectedAction)

func actionSelected(index: int):
	currentSelectedAction = player.actionChosen(index)
	isActionItem = false
	setupSelection(currentSelectedAction)

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	showSubMenu(selectionMenu)

func actionTargetSelected():
	if(isActionItem):
		player.itemDiscarded(itemIndex)
	
	closeMenuSystem()

func changeStatsHealth(remaningHP: int):
	stats.changeHealth(remaningHP)

func showMinigame(case: bool):
	playerMenu.actionMenu.visible = !case
	playerMenu.attackMenu.visible = false
	#self.visible = case
	playerMenu.visible = case
	minigameContainer.visible = case

func showPlayerMenu(case: bool):
	self.visible = case
	playerMenu.visible = case
	playerMenu.actionMenu.visible = false
