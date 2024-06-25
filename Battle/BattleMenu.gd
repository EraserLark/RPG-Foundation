extends Panel

@onready var ActionMenu := $ActionMenu
@onready var AttackMenu := $AttackMenu
@onready var ItemMenu := $ItemMenu

var prevFocused : Control = null

func _ready():
	ActionMenu.openAttackMenu.connect(OpenAttackMenu)
	AttackMenu.closeAttackMenu.connect(CloseAttackMenu)
	ActionMenu.openItemMenu.connect(OpenItemMenu)
	ItemMenu.closeItemMenu.connect(CloseItemMenu)

func OpenAttackMenu():
	AttackMenu.visible = true
	prevFocused = get_viewport().gui_get_focus_owner()
	AttackMenu.itemList.grab_focus()
	AttackMenu.itemList.select(0)

func CloseAttackMenu():
	AttackMenu.visible = false
	prevFocused.grab_focus()
	#ActionMenu.attackButton.grab_focus()

func OpenItemMenu():
	ItemMenu.visible = true
	prevFocused = get_viewport().gui_get_focus_owner()
	ItemMenu.itemList.grab_focus()
	ItemMenu.itemList.select(0)

func CloseItemMenu():
	ItemMenu.visible = false
	prevFocused.grab_focus()
