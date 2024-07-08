extends TabBar

@onready var attackButton := $"AttackButton"

var playerUI

func _ready():
	attackButton.grab_focus()

func _on_attack_button_button_down():
	playerUI.OpenActionMenu(0)

func _on_item_button_button_down():
	playerUI.OpenActionMenu(1)

func _on_react_button_button_down():
	playerUI.OpenActionMenu(2)
