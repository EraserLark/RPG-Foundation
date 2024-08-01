extends MenuSystem
class_name PlayerPanel

@onready var playerUI:= $".."
@onready var stats:= $Stats
@onready var playerMenu:= $PlayerMenu
@onready var selectionMenu:= $"../SelectionMenu"
@onready var playerPointer:= $"../SelectionMenu/PlayerPointer"

@onready var minigameContainer:= $PlayerMenu/MarginContainer/SubViewportContainer
@onready var minigameView:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport
@onready var minigameZone:= $PlayerMenu/MarginContainer/SubViewportContainer/SubViewport/MinigameZone

var player: PlayerEntity
var battleManager
var currentSelectedAction

func _ready():
	playerMenu.populateVars(self)

func open():
	baseMenu = playerMenu
	player = playerUI.player
	super()

func attackSelected(index: int):
	currentSelectedAction = player.attackChosen(index)
	setupSelection(currentSelectedAction)

func actionSelected(index: int):
	currentSelectedAction = player.actionChosen(index)
	setupSelection(currentSelectedAction)

func itemSelected(index: int):
	currentSelectedAction = player.itemChosen(index)
	setupSelection(currentSelectedAction)

func setupSelection(selectedAction: Action):
	get_viewport().set_input_as_handled() #prevents input from carrying thru
	showSubMenu(selectionMenu)

func actionTargetSelected():
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
