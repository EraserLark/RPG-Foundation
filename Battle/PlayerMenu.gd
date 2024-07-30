extends Menu
class_name PlayerBattleMenu

@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $AttackMenu
@onready var itemMenu:= $ItemMenu
@onready var miscMenu:= $MiscMenu

func _ready():
	firstFocus = actionMenu.attackButton

func populateVars(pUI):
	actionMenu.playerUI = pUI
	attackMenu.playerUI = pUI
	itemMenu.playerUI = pUI
	miscMenu.playerUI = pUI
