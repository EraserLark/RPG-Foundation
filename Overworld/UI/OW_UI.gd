extends Control

##Children References
@onready var playerUI:= $PlayerUI
@onready var playerMenu:= $PlayerUI/PlayerMenu
@onready var tbContainer:= $TBContainer
@onready var fadeScreen:= $Fade

##Non export vars
var owManager: OverworldManager

#Runs after all nodes have finished _ready()
func initialize(om: OverworldManager):
	owManager = om
	playerUI.initialize(om)
	playerMenu.initialize(om)

func showPlayerMenu(condition: bool):
	playerMenu.visible = condition
