extends State
class_name ManualMenu_State

var menuSystem: MenuSystem
var playerInput: DeviceInput

func _init(sStack: StateStack, pi: DeviceInput, m: MenuSystem):
	super(sStack)
	playerInput = pi
	menuSystem = m

func enter(_msg:= {}):
	menuSystem.open(stateStack)

func resumeState():
	if(menuSystem.isFinished):
		exit()
	else:
		menuSystem.resumeSubMenu()

##For directional input
func update(delta):
	menuSystem.menuStack.currentMenu.runMenuUpdate(playerInput)

##For button presses
func handleInput(_event: InputEvent):
	#Accomodate keyboard inputs registered as 0 in _event, -1 in DeviceInput
	#This means keyboard can only be player 1
	#But also Controller 1 will be listed as 0 lmaooooo in _event
	#if playerInput.is_keyboard():
		#if _event.device <= 0:
			#menuSystem.menuStack.currentMenu.buttonPressed(_event)
	#elif _event.device == playerInput.device:
		#menuSystem.menuStack.currentMenu.buttonPressed(_event)
	
	menuSystem.menuStack.currentMenu.buttonPressed(_event)

func exit():
	super()

func changeDeviceNum(newNum: int):
	super(newNum)
	playerInput = stateStack.playerEntity.input	#Don't create new input
