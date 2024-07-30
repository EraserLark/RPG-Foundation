extends State
class_name MenuState

var menu: MenuSystem

func _init(sStack: StateStack, m):
	super(sStack)
	menu = m

func enter(_msg:= {}):
	menu.open()

func resumeState():
	if(menu.isFinished):
		exit()
	else:
		menu.menuStack.currentMenu.ResumeMenu()

func exit():
	super()
