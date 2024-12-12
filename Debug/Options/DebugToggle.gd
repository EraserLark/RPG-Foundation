class_name DebugToggle
extends Container

@onready var _label: Label = $Label
@onready var _button : Button = $Button

var _debugFlag : DebugManager.Flags

func initialize(flag: DebugManager.Flags):
	_debugFlag = flag

	# Use enum flag name as label  
	_label.text = DebugManager.Flags.keys()[_debugFlag]

	# Update appropriate debug flag when button is toggled 
	_button.toggled.connect(_on_toggled)

	# Initialize flag to match toggle on startup
	_on_toggled(_button.is_pressed())


func _on_toggled(newValue: bool):
	DebugManager.set_flag(_debugFlag, newValue)
