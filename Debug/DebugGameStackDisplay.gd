extends Control
class_name DebugGameStackDisplay

@onready var text: Label = $StackText

var stackCount: int = -1;
var topState: GameState = null;

# Inefficient, but should work. Can replace with signal listeners when appropriate
func _process(_delta):
	_update_data()

func _update_data() -> void:
	var stack := GameStateStack.gameStateStack
	var stackChanged: bool = (stack.size() != stackCount || stack.front() != topState)
	if (!stackChanged): return

	var displayString: String = ""

	for state in stack:
		displayString = _get_state_name(state) + '\n' + displayString

	text.text = displayString
	
	
func _get_state_name(state: GameState) -> String:
	var filename : String = state.get_script().resource_path.get_file()
	return filename.trim_suffix(".gd") # remove script suffix
	
