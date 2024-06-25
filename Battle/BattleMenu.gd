extends Panel

@onready var ActionMenu := $ActionMenu
@onready var AttackMenu := $AttackMenu

func _ready():
	ActionMenu.openAttackMenu.connect(OpenAttackMenu)

func OpenAttackMenu():
	AttackMenu.visible = true

func CloseAttackMenu():
	AttackMenu.visible = false
