extends Menu
class_name PlayerBattleMenu

@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $MarginContainer/AttackMenu
@onready var itemMenu:= $MarginContainer/ItemMenu
@onready var miscMenu:= $MarginContainer/MiscMenu

func _ready():
	firstFocus = actionMenu.attackButton

func populateVars(pUI):
	actionMenu.menuManager = pUI
	attackMenu.menuManager = pUI
	itemMenu.menuManager = pUI
	miscMenu.menuManager = pUI
