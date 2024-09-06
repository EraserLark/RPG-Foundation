extends PlayerPanel
class_name PlayerPanel_Battle

##Children references
@onready var stats:= $Stats
@onready var playerMenu:= $PlayerMenu
@onready var minigameContainer:= $PlayerMenu/MarginContainer/MinigameView
@onready var minigameView:= $PlayerMenu/MarginContainer/MinigameView/SubViewport
@onready var minigameZone:= $PlayerMenu/MarginContainer/MinigameView/SubViewport/MinigameZone
#@onready var panelAnchorNodes:= $PanelAnchors

##Parent/Outside references
var battleManager: BattleManager
var playerUI: PlayerUI_Battle
var selectionMenu: TargetSelectionMenu
var playerPointer: Cursor
#var player: PlayerEntity

##Inside vars
var currentSelectedAction
var isActionItem:= false
var itemIndex
var panelAnchors: Array

func _ready():
	audioPlayer = $AudioStreamPlayer
	panelAnchors = $PanelAnchors.get_children()

func initialize(bm: BattleManager, pui: PlayerUI_Battle, pe: PlayerEntity):
	battleManager = bm
	playerUI = pui
	selectionMenu = playerUI.selectionMenu
	playerPointer = selectionMenu.playerPointer
	playerEntity = pe
	#player = pe
	
	stats.initialize(playerEntity.entityInfo)
	playerMenu.initialize(self)
	
	#stats.setInitialHealth()

func open(sStack: StateStack):
	baseMenu = playerMenu
	#player = playerUI.player
	super(sStack)

func attackSelected(index: int):
	currentSelectedAction = playerEntity.attackChosen(index)
	isActionItem = false
	setupSelection(currentSelectedAction)

func itemSelected(index: int):
	currentSelectedAction = playerEntity.itemChosen(index)
	isActionItem = true
	itemIndex = index
	setupSelection(currentSelectedAction)

func actionSelected(index: int):
	currentSelectedAction = playerEntity.actionChosen(index)
	isActionItem = false
	setupSelection(currentSelectedAction)

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	showSubMenu(selectionMenu)

func actionTargetSelected():
	if(isActionItem):
		playerEntity.itemDiscarded(itemIndex)
	
	closeMenuSystem()

func changeStatsHealth(remaningHP: int):
	stats.changeHealth(remaningHP)

func showMinigame(case: bool):
	playerMenu.actionSelectionMenu.visible = !case
	playerMenu.attackMenu.visible = false
	#self.visible = case
	playerMenu.visible = case
	minigameContainer.visible = case

##Used when showing textbox inside player panel
func showPlayerMenu(case: bool):
	self.visible = case
	playerMenu.visible = case
	playerMenu.actionSelectionMenu.visible = false
