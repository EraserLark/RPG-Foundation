extends Menu
class_name PlayerBattleMenu

@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $MarginContainer/AttackMenu
@onready var itemMenu:= $MarginContainer/ItemMenu
@onready var miscMenu:= $MarginContainer/MiscMenu

func _ready():
	firstFocus = actionMenu.attackButton

func populateVars(pp):
	actionMenu.menuManager = pp
	attackMenu.menuManager = pp
	itemMenu.menuManager = pp
	miscMenu.menuManager = pp
