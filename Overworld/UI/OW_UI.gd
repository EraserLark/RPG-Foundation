extends Control

@onready var playerUI:= $PlayerUI
@onready var playerMenu:= $PlayerUI/PlayerMenu
@onready var tbContainer:= $TBContainer

func showPlayerMenu(condition: bool):
	playerMenu.visible = condition
