extends GameState
class_name GameState_PromptPhase

var phaseManager: PhaseManager
var menuSystems: Array[MenuSystem]

func _init(pm:PhaseManager, _msg:={}):
	phaseManager = pm

func enter(playerNum: int, _msg:= {}):
	menuSystems[playerNum] = PlayerRoster.roster[playerNum].battleUI.playerPanel
	menuSystems[playerNum].open(PlayerRoster.roster[playerNum].playerStateStack)

func resumeState(playerNum: int):
	if(menuSystems[playerNum].isFinished):
		playerSubmit()
	else:
		menuSystems[playerNum].resumeSubMenu()

##For directional input
func update(playerNum: int, delta):
	menuSystems[playerNum].menuStack.currentMenu.runMenuUpdate(PlayerRoster.roster[playerNum].input)

##For button presses
func handleInput(playerNum: int, _event: InputEvent):
	if _event.device != PlayerRoster.roster[playerNum].deviceNumber:
		return
	
	menuSystems[playerNum].menuStack.currentMenu.buttonPressed(_event)

func playerSubmit():
	for menuSystem in menuSystems:
		if !menuSystem.isFinished:
			return
	stackExit()	#Only call once all players have submitted!

func stackExit():
	super()
	phaseManager.phaseFinished()

func cleanPhase():
	pass