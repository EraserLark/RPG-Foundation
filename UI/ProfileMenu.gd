extends ManualMenu
class_name ProfileSelectionMenu

#@onready var goButton:= $VBoxContainer/Button
var rosterNum: int
var deviceNum

func _ready():
	firstFocus = null
	deviceNum = PlayerRoster.roster[rosterNum].deviceNumber

func OpenMenu():
	super()

func activateOption():
	menuManager.closeMenuSystem()
	PlayerRoster.addProfileToRoster(PlayerRoster.profileBank[rosterNum], rosterNum)
	get_viewport().set_input_as_handled()

func rejectMenu():
	PlayerRoster.removePlayer(deviceNum)
	super()
