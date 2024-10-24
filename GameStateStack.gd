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
	foundationGameState = gameStateStack.back()
	print("\nGSS")
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	#Run game state enter once
	frontGameState.stackEnter(_msg)

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

#Adds game state connections for all game states in stack to pss
func CatchUpOnStates(playerStateStack: StateStack):
	##Iterate backward through the state stack (start with most foundational state (overworld))
	for i in range(gameStateStack.size()-1, -1, -1):
	#for gameState in gameStateStack:
		var connectionState = GameState_Connection.new(playerStateStack, gameStateStack[i])
		playerStateStack.addState(connectionState)	#Enters game state roundabout
