extends State
class_name MenuState

var menu: MenuSystem

func _init(sStack: StateStack, m: MenuSystem):
	super(sStack)
	menu = m

func enter(_msg:= {}):
	menu.open(stateStack)

func resumeState():
	if(menu.isFinished):
		exit()
	else:
		menu.menuStack.currentMenu.ResumeMenu()

func update(delta):
	if(MultiplayerInput.is_action_just_pressed(localDeviceNum, "ui_cancel")):
		menu.backOut()

func exit():
	super()
