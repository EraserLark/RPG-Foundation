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

func update(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		menu.backOut()

func exit():
	super()
