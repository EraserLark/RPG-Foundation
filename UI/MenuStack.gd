extends Node
class_name MenuStack

var currentMenu: Menu = null
var stack: Array[Menu] = []

func pushMenu(menu: Menu):
	if(currentMenu):
		currentMenu.setPrevFocus()
	
	stack.push_front(menu)
	currentMenu = stack.front()
	currentMenu.OpenMenu()

func popMenu():
	currentMenu.CloseMenu()
	stack.pop_front()
	
	if(stack.size() <= 0):
		currentMenu = null
	else:
		currentMenu = stack.front()
		currentMenu.ResumeMenu()

func emptyStack():
	stack.clear()
	currentMenu = null
