## Controls lifetime of the player stack display objects in the debug menu

extends Control
class_name DebugPlayerStackController

## Scene to use as the display ui for each player. Must be a [DebugPlayerStackDisplay] at the root.
@export var _display_scene: PackedScene

@onready var _display_container: Container = $DisplayContainer

func _ready() -> void:
	InputManager.newPlayerJoined.connect(_on_player_joined)
	InputManager.playerLeft.connect(_on_player_left)
	

func _on_player_joined(deviceNum: int) -> void:
	print("Debug: Player %d joined!", deviceNum)
	var display := _display_scene.instantiate() as DebugPlayerStackDisplay;
	_display_container.add_child(display);
	display.initialize(deviceNum)


func _on_player_left(deviceNum: int) -> void:
	print("Debug: Player %d left!", deviceNum)
	for display : DebugPlayerStackDisplay in _display_container.get_children():
		if deviceNum == display.deviceNum:
			display.queue_free()
			return
