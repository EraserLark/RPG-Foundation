extends Panel

@onready var ActionMenu := $ActionMenu
@onready var AttackMenu := $AttackMenu
@onready var ItemMenu := $ItemMenu

var prevFocused : Control = null

signal moveToActionPhase

func _ready():
	ActionMenu.openAttackMenu.connect(OpenAttackMenu)
	AttackMenu.attackSelected.connect(actionSelected)
	ActionMenu.openItemMenu.connect(OpenItemMenu)
	ItemMenu.closeItemMenu.connect(CloseItemMenu)

func showMenu():
	visible = true
	ActionMenu.attackButton.grab_focus()

func hideMenu():
	visible = false

func actionSelected(index : int):
	CloseAttackMenu()
	hideMenu()
	emit_signal("moveToActionPhase")

func OpenAttackMenu():
	AttackMenu.visible = true
	prevFocused = get_viewport().gui_get_focus_owner()
	AttackMenu.itemList.grab_focus()
	AttackMenu.itemList.select(0)

func CloseAttackMenu():
	AttackMenu.visible = false
	prevFocused.grab_focus()

func OpenItemMenu():
	ItemMenu.visible = true
	prevFocused = get_viewport().gui_get_focus_owner()
	ItemMenu.itemList.grab_focus()
	ItemMenu.itemList.select(0)

func CloseItemMenu():
	ItemMenu.visible = false
	prevFocused.grab_focus()
