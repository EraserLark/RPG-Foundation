extends Menu

##Children references
@onready var attackButton:= $"AttackButton"

##Parent references
@onready var attackMenu:= $"../MarginContainer/AttackMenu"
@onready var itemMenu:= $"../MarginContainer/ItemMenu"
@onready var miscMenu:= $"../MarginContainer/MiscMenu"

func _ready():
	#firstFocus = attackButton
	pass

func _on_attack_button_button_down():
	menuManager.showSubMenu(attackMenu)

func _on_item_button_button_down():
	menuManager.showSubMenu(itemMenu)

func _on_react_button_button_down():
	menuManager.showSubMenu(miscMenu)
