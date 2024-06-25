extends HBoxContainer

@onready var attackButton := $"AttackButton"

signal openAttackMenu

var currentMenu = null

func _ready():
	attackButton.grab_focus()

func _on_attack_button_button_down():
	emit_signal("openAttackMenu")
