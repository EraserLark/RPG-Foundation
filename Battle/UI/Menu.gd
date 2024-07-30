extends Control
class_name Menu

var playerUI: MenuSystem
var isOpen
var firstFocus
var prevFocused

#func _unhandled_input(event):
	#if(isOpen):
		#if(event.is_action_pressed("ui_cancel")):
			#playerUI.CloseActionMenu()

func OpenMenu():
	self.visible = true
	isOpen = true
	grabFirstFocus()

func ResumeMenu():
	self.visible = true
	isOpen = true
	if(prevFocused):
		grabPrevFocused()
	else:
		grabFirstFocus()

func CloseMenu():
	self.visible = false
	isOpen = false

func setPrevFocus():
	prevFocused = get_viewport().gui_get_focus_owner()

func grabFirstFocus():
	firstFocus.grab_focus()

func grabPrevFocused():
	prevFocused.grab_focus()
