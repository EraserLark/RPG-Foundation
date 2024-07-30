extends Control
class_name MenuSystem

var baseMenu: Menu
var subMenus: Array[Menu]
var menuStack: MenuStack = MenuStack.new()

var isFinished:= false
@export var mandatory:= false

func open():
	showSubMenu(baseMenu)

func showSubMenu(menu: Menu):
	menuStack.pushMenu(menu)

func closeSubMenu():
	if(menuStack.currentMenu == baseMenu && mandatory):
		return
	else:
		menuStack.popMenu()
	
	if(menuStack.currentMenu == null):
		isFinished = true
		StateStack.resumeCurrentState()
