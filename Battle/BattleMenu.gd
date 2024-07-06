extends Panel

@onready var ActionMenu := $ActionMenu
@onready var AttackMenu := $AttackMenu
@onready var ItemMenu := $ItemMenu
@onready var player := $"../../../BA_Player"

var prevFocused : Control = null

signal selectionMade

func _ready():
	ActionMenu.openAttackMenu.connect(OpenAttackMenu)
	AttackMenu.attackSelected.connect(actionSelected)
	ActionMenu.openItemMenu.connect(OpenItemMenu)
	ItemMenu.closeItemMenu.connect(CloseItemMenu)

func showActionMenu():
	visible = true
	ActionMenu.attackButton.grab_focus()

func hideMenu():
	visible = false

func actionSelected(index : int):
	CloseAttackMenu()
	hideMenu()
	
	player.playerInfo.selectedAction = player.playerInfo.actionList[index]
	
	emit_signal("selectionMade")

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
