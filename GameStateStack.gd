extends Node
##Game State Stack Autoload

var gameStateStack: Array[GameState]
var frontGameState: GameState = null
var foundationGameState: GameState = null

func _init():
	pass
	#var baseState = GameState.new()
	#addGameState(baseState)

func addGameState(gs: GameState, _msg:={}):
	gameStateStack.push_front(gs)
	frontGameState = gameStateStack.front()
	#frontGameState.stateStack = gameStateStack
	foundationGameState = gameStateStack.back()
	#foundationGameState.stateStack = gameStateStack
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	for playerEntity in PlayerRoster.getActiveRoster():
		var connectionState = GameState_Connection.new(playerEntity.playerStateStack, frontGameState)
		playerEntity.playerStateStack.addState(connectionState)	#Enters game state roundabout

#func resumeCurrentState():
	#frontGameState.resumeState()

func removeState():
	for playerEntity in PlayerRoster.getActiveRoster():
		playerEntity.playerStateStack.removeGameState()
	
	gameStateStack.pop_front()
	if(gameStateStack.is_empty()):
		print("STACK EMPTY")
	frontGameState = gameStateStack.front()
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")
	
	for playerEntity in PlayerRoster.getActiveRoster():
		playerEntity.playerStateStack.resumeCurrentState()
	
	#resumeCurrentState()

#func _unhandled_input(event):
	#gameStateStack.currentState.handleInput(event)
#
#func _process(delta):
	#gameStateStack.currentState.update(delta)
#
#func _physics_process(delta):
	#gameStateStack.currentState.physicsUpdate(delta)
