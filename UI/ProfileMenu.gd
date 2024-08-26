extends Menu
class_name ProfileSelectionMenu

@onready var goButton:= $VBoxContainer/Button

func _ready():
	firstFocus = goButton

func OpenMenu():
	super()

func _on_button_pressed():
	menuManager.closeMenuSystem()
	PlayerRoster.addProfileToRoster(PlayerRoster.profileBank[0])
	#menuManager.swapSubMenu(menuManager.baseMenu)
