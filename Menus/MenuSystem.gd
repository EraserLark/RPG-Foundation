extends Control
class_name MenuSystem

var baseMenu: Menu
var subMenus: Array[Menu]
var menuStack: MenuStack = MenuStack.new()

var audioPlayer: AudioStreamPlayer
@export var sounds: Array[AudioStreamMP3]

var isFinished:= false
@export var mandatory:= false

func open():
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

func backOut():
	if(menuStack.currentMenu == baseMenu && mandatory):
		return
	#else:
		#closeSubMenu()

func closeMenuSystem():
	menuStack.emptyStack() 
	isFinished = true
	StateStack.resumeCurrentState()
