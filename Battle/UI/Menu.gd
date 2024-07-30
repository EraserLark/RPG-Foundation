extends Control
class_name Menu

var playerUI
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
	firstFocus.grab_focus()

func ResumeMenu():
	self.visible = true
	isOpen = true
	if(prevFocused):
		prevFocused.grab_focus()
	else:
		firstFocus.grab_focus()

func CloseMenu():
	self.visible = false
	isOpen = false

func setPrevFocus():
	prevFocused = get_viewport().gui_get_focus_owner()
