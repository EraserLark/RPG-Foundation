# singleton DebugManager class
extends Node

## Input action used to toggle on and off the debug overlay
const TOGGLE_ACTION := "debug_toggle"

# child references
@onready var debugCanvas: CanvasLayer = $DebugCanvas

# export variables

## Is debug functionality available?
@export var _enable_debug: bool = true


func debug_is_enabled() -> bool: return _enable_debug && (OS.has_feature("debug"))


func _ready() -> void:
	if (!debug_is_enabled()):
		print("Debug mode disabled. Destroying Debug Menu")
		debugCanvas.queue_free()
		return


func _input(event: InputEvent) -> void:
	if debug_is_enabled() and event.is_action_pressed(TOGGLE_ACTION):
		_toggle_debug_menu()


func _toggle_debug_menu():
	debugCanvas.visible = !debugCanvas.visible;
	
