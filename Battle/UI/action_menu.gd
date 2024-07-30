extends Menu

@onready var attackButton:= $"AttackButton"
@onready var attackMenu:= $"../AttackMenu"
@onready var itemMenu:= $"../ItemMenu"
@onready var miscMenu:= $"../MiscMenu"

func _ready():
	#firstFocus = attackButton
	pass

func _on_attack_button_button_down():
	playerUI.showSubMenu(attackMenu)

func _on_item_button_button_down():
	playerUI.showSubMenu(itemMenu)

func _on_react_button_button_down():
	playerUI.showSubMenu(miscMenu)
