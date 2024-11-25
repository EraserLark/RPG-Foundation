## Displays the state stack for a given player in the debug menu

extends Control
class_name DebugPlayerDataDisplay

# Child Nodes
@onready var stackText: Label = $DataContainer/StackTextPanel/StackText
@onready var playerNumText: Label = $DataContainer/PlayerNumContainer/PlayerNumText

# Change-detection cache variables
var stackCount: int = -1
var topState: State = null

# Persistent information
var _playerStateStack: StateStack
var deviceNum: int = -99


func initialize(deviceNumber: int):
	self.deviceNum = deviceNumber
	playerNumText.text = str(deviceNumber)


# As with the Game State equivalent, this can be made more efficient using signals from the appropriate player state machine
func _process(_delta):
	_update_data()


func _update_data() -> void:
	# cannot display if player stack does not yet exist
	if _playerStateStack == null and not _try_cache_stack_from_roster(): return

	var stack := _playerStateStack.stateStack
	var stackChanged: bool = (stack.size() != stackCount || stack.front() != topState)
	if (!stackChanged): return

	stackCount = stack.size()
	topState = stack.front()

	var displayString: String = ""

	# Create new lines for each state in the stack, growing downwards
	var lineNumber: int = stack.size() - 1
	for state: State in stack:
		var newLine: String = "%d. %s\n" % [lineNumber, _get_state_name(state)] # state with number label
		displayString = newLine + displayString
		lineNumber -= 1

	stackText.text = displayString


## Attempt to find and cache player state stack for assigned player number in roster. 
## Returns true if successful
func _try_cache_stack_from_roster() -> bool:
	for player: PlayerEntity in PlayerRoster.roster:
		if player.deviceNumber == deviceNum:
			_playerStateStack = player.playerStateStack
			return true
	return false


## Retrieve name of state based on filename of its script
func _get_state_name(state: State) -> String:
	var filename: String = state.get_script().resource_path.get_file()
	return filename.trim_suffix(".gd") # remove script suffix
	