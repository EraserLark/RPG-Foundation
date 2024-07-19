extends Panel

@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $AttackMenu
@onready var itemMenu:= $ItemMenu
@onready var miscMenu:= $MiscMenu

var playerUI

func populateVars(pUI):
	actionMenu.playerUI = pUI
	attackMenu.playerUI = pUI
	itemMenu.playerUI = pUI
	miscMenu.playerUI = pUI
