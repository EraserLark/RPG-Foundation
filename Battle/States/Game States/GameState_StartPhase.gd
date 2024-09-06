extends GameState
class_name GameState_StartPhase

var phaseManager: GameState_PhaseManager
var battleManager
var alreadyResumed = false

func _init(pm:GameState_PhaseManager, bm: BattleManager, _msg:={}):
	phaseManager = pm
	battleManager = bm

func stackEnter(_msg := {}):
	super()
	var introCutscene = BattleIntro.new(battleManager.cutsceneManager, battleManager)

func stackResume():
	stackExit()

func resume():
	if !alreadyResumed:
		alreadyResumed = true
		stackResume()

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
