extends PlayerPanel
class_name PlayerPanel_Battle

##Children references
@onready var stats:= $Panel/Stats
@onready var playerMenu:= $Panel/PlayerMenu
@onready var minigameContainer:= $Panel/PlayerMenu/MarginContainer/MinigameView
@onready var minigameView:= $Panel/PlayerMenu/MarginContainer/MinigameView/SubViewport
@onready var minigameZone:= $Panel/PlayerMenu/MarginContainer/MinigameView/SubViewport/MinigameZone

##Parent/Outside references
var battleManager: BattleManager
#var playerUI: PlayerUI_Battle
var selectionMenu: TargetSelectionMenu
var playerPointer: Cursor

##Inside vars
@export var healthbarFlipped:= false
@export var actionButtonsFlipped:= false
var currentSelectedAction: Action
var isActionItem:= false
var itemIndex
var panelAnchors: Array

func _ready():
	audioPlayer = $Panel/AudioStreamPlayer
	panelAnchors = $Panel/PanelAnchors.get_children()

func initialize(bm: BattleManager, pui: PlayerUI_Battle, pe: PlayerEntity):
	battleManager = bm
	playerUI = pui
	selectionMenu = playerUI.selectionMenu
	playerPointer = selectionMenu.playerPointer
	playerEntity = pe
	
	stats.initialize(playerEntity.entityInfo)
	playerMenu.initialize(self)

func open(sStack: StateStack):
	baseMenu = playerMenu
	isFinished = false
	super(sStack)

func flipHealthbar(condition: bool):
	healthbarFlipped = condition
	
	if healthbarFlipped:
		stats.set_anchors_preset(Control.PRESET_TOP_RIGHT)
		stats.position.x = 288
	else:
		stats.set_anchors_preset(Control.PRESET_TOP_LEFT)
		stats.position.x = -16
	
func flipActionButtons(condition: bool):
	actionButtonsFlipped = condition
	
	if actionButtonsFlipped:
		playerMenu.actionSelectionMenu.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
		playerMenu.actionSelectionMenu.position.y = 136
	else:
		playerMenu.actionSelectionMenu.set_anchors_preset(Control.PRESET_TOP_LEFT)
		playerMenu.actionSelectionMenu.position.y = -40

func attackSelected(index: int):
	currentSelectedAction = playerEntity.attackChosen(index)
	isActionItem = false
	setupSelection(currentSelectedAction)

func itemSelected(index: int):
	currentSelectedAction = playerEntity.itemChosen(index)
	isActionItem = true
	itemIndex = index
	
	currentSelectedAction.target = playerEntity
	actionTargetSelected()

func actionSelected(index: int):
	currentSelectedAction = playerEntity.actionChosen(index)
	isActionItem = false
	
	currentSelectedAction.target = playerEntity
	actionTargetSelected()

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	showSubMenu(selectionMenu)

func actionTargetSelected():
	if(isActionItem):
		playerEntity.itemDiscarded(itemIndex)
	
	showSubMenu(playerMenu.waitingMenu)

func changeStatsHealth(remaningHP: int):
	stats.changeHealth(remaningHP)

func showMinigame(case: bool):
	playerMenu.actionSelectionMenu.visible = !case
	playerMenu.attackMenu.visible = false
	playerMenu.visible = case
	minigameContainer.visible = case

##Used when showing textbox inside player panel
func showPlayerMenu(case: bool):
	self.visible = case
	playerMenu.visible = case
	playerMenu.actionSelectionMenu.visible = false
