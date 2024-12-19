extends Menu
class_name ManualMenu

var prevFocus: int = 0

##Direct feed of 'update()' from the ManualMenuState
func runMenuUpdate(input: DeviceInput):
	pass

##Direct feed of 'handleInput()' from the ManualMenuState
func buttonPressed(_event: InputEvent):
	if(_event.is_action_pressed("ui_accept")):
		activateOption()
		get_viewport().set_input_as_handled()
	elif(_event.is_action_pressed("ui_cancel")):
		rejectMenu()
		get_viewport().set_input_as_handled()
	
	print("Menu state active")

func activateOption():
	pass

func rejectMenu():
	menuManager.backOut()

func setPrevFocus():
	#Set this to store number of prev selection
	pass
