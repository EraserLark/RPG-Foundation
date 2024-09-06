extends GameState
class_name GameState_PromptPhase

var phaseManager: GameState_PhaseManager
var menuSystems: Array

func _init(pm:GameState_PhaseManager, _msg:={}):
	phaseManager = pm

func enter(playerNum: int, _msg:= {}):
	var playerEntity = PlayerRoster.roster[playerNum]
	var playerPanel = playerEntity.battleUI.playerPanel
	menuSystems.append(playerPanel)
	menuSystems[playerNum].open(playerEntity.playerStateStack)

#Runs the 'resumeState()' func in each player's GameState_Connection state
func stackResume():
	super()

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
	for playerEntity in PlayerRoster.getActiveRoster():
		playerEntity.playerStateStack.removeGameState()
	
	var gameStateStack = GameStateStack.gameStateStack
	gameStateStack.pop_front()
	if(gameStateStack.is_empty()):
		print("STACK EMPTY")
	GameStateStack.frontGameState = gameStateStack.front()
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")

	phaseManager.phaseFinished()

func cleanPhase():
	pass
