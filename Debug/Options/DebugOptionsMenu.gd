class_name DebugOptionsMenu
extends Node

@onready var _disableEnemiesToggle: CheckBox = $List/DisableEnemies/Toggle


# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_toggle(_disableEnemiesToggle, DebugManager.Flags.DISABLE_ENEMIES)
	
## Initialize a given debug option in the debug manager and connect appropriate signals
func _initialize_toggle(toggle: Button, flag: int):
	toggle.toggled.connect(func(val: bool):
		DebugManager.set_flag(flag, val))
	DebugManager.set_flag(flag, toggle.is_pressed())