extends Node
##Game State Stack Autoload

var gameStateStack: Array[GameState]
var frontGameState: GameState = null
var foundationGameState: GameState = null

func _init():
	pass

func addGameState(gs: GameState, _msg:={}):
	gameStateStack.push_front(gs)
	frontGameState = gameStateStack.front()
	#frontGameState.stateStack = gameStateStack
	foundationGameState = gameStateStack.back()
	#foundationGameState.stateStack = gameStateStack
	print("\nGSS")
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	#Run game state enter once
	frontGameState.stackEnter(_msg)
	
	##Run each player's enter (game state enter by extentsion)
	#for playerEntity in PlayerRoster.getActiveRoster():
		#var connectionState = GameState_Connection.new(playerEntity.playerStateStack, frontGameState)
		#playerEntity.playerStateStack.addState(connectionState)	#Enters game state roundabout

func resumeCurrentState():
	frontGameState.stackResume()

func removeState():
	for playerEntity in PlayerRoster.getActiveRoster():
		playerEntity.playerStateStack.removeGameState()
	
	gameStateStack.pop_front()
	if(gameStateStack.is_empty()):
		print("STACK EMPTY")
	frontGameState = gameStateStack.front()
	print("\nGSS")
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	resumeCurrentState()
