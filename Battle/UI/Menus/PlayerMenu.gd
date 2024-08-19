extends Menu
class_name PlayerBattleMenu

##Children references
@onready var actionMenu:= $ActionMenu
@onready var attackMenu= $MarginContainer/AttackMenu
@onready var itemMenu:= $MarginContainer/ItemMenu
@onready var miscMenu:= $MarginContainer/MiscMenu

func _ready():
	firstFocus = actionMenu.attackButton

func initialize(pp: PlayerPanel_Battle):
	actionMenu.menuManager = pp
	attackMenu.menuManager = pp
	itemMenu.menuManager = pp
	miscMenu.menuManager = pp
	
	actionMenu.attackMenu = attackMenu
	actionMenu.itemMenu = itemMenu
	actionMenu.miscMenu = miscMenu
