extends Control

@onready var playerMenu:= $PlayerMenu

func showPlayerMenu(condition: bool):
	playerMenu.visible = condition
