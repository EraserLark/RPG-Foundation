extends TabBar

@onready var attackButton := $"AttackButton"

var playerUI

signal openAttackMenu
signal openItemMenu

var currentMenu = null

func _ready():
	attackButton.grab_focus()

func _on_attack_button_button_down():
	emit_signal("openAttackMenu")

func _on_item_button_button_down():
	emit_signal("openItemMenu")
