extends Menu
class_name PlayerBattleMenu

@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $AttackMenu
@onready var itemMenu:= $ItemMenu
@onready var miscMenu:= $MiscMenu

func _ready():
	firstFocus = actionMenu.attackButton

func populateVars(pUI):
	actionMenu.menuManager = pUI
	attackMenu.menuManager = pUI
	itemMenu.menuManager = pUI
	miscMenu.menuManager = pUI
