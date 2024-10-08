extends Control
class_name MenuSystem

var baseMenu: Menu
var subMenus: Array[Menu]
var menuStack: MenuStack = MenuStack.new()
var ownerStack: StateStack

var audioPlayer: AudioStreamPlayer
@export var sounds: Array[AudioStreamMP3]

var isFinished:= false
@export var mandatory:= false

func open(sStack: StateStack):
	ownerStack = sStack
	showSubMenu(baseMenu)

func showSubMenu(menu: Menu):
	menuStack.pushMenu(menu)
	if(sounds.size() > 0):
		audioPlayer.stream = sounds[0]
		audioPlayer.play()

func closeSubMenu():
	menuStack.popMenu()
	if(sounds.size() > 1):
		audioPlayer.stream = sounds[1]
		audioPlayer.play()
	
	if(menuStack.currentMenu == null):
		closeMenuSystem()

#Closes current submenu before swapping to a different one
func swapSubMenu(swapToMenu: Menu):
	menuStack.popMenu()
	showSubMenu(swapToMenu)

func resumeSubMenu():
	menuStack.currentMenu.ResumeMenu()

func backOut():
	if(menuStack.currentMenu == baseMenu && mandatory):
		return
	#Edge case for player battle menu (menuStack has playerMenu and Manual menu seperate)
	elif(menuStack.currentMenu is ManualMenu_ButtonList && mandatory):
		return
	else:
		closeSubMenu()

func closeMenuSystem():
	menuStack.emptyStack() 
	isFinished = true
	ownerStack.resumeCurrentState()
