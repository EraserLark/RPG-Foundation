extends Menu
class_name ManualMenu

##Direct feed of 'update()' from the ManualMenuState
func runMenuUpdate(input: DeviceInput):
	pass

##Direct feed of 'handleInput()' from the ManualMenuState
func buttonPressed(_event: InputEvent):
	if(_event.is_action_pressed("ui_accept")):
		activateOption()
	elif(_event.is_action_pressed("ui_cancel")):
		menuManager.backOut()

func activateOption():
	pass
