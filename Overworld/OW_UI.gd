extends Control

@onready var playerMenu:= $PlayerMenu
@onready var tbContainer:= $TBContainer

func showPlayerMenu(condition: bool):
	playerMenu.visible = condition
