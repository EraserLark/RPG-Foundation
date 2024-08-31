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
	PlayerRoster.addProfileToRoster(PlayerRoster.profileBank[0], rosterNum)
	get_viewport().set_input_as_handled()

#func _unhandled_input(event):
	#if event.is_action_pressed(str(deviceNum, "ui_accept")):
#

#func _on_button_pressed():
	#menuManager.closeMenuSystem()
	#PlayerRoster.addProfileToRoster(PlayerRoster.profileBank[0], rosterNum)
	#menuManager.swapSubMenu(menuManager.baseMenu)
