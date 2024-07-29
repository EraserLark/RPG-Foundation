extends Container
class_name Menu

var playerUI
var isOpen

func _unhandled_input(event):
	if(isOpen):
		if(event.is_action_pressed("ui_cancel")):
			playerUI.CloseActionMenu()

func OpenMenu():
	self.visible = true
	isOpen = true

func CloseMenu():
	self.visible = false
	isOpen = false
