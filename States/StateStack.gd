extends Node
class_name StateStack

var stateStack: Array[State]
var currentState: State = null
var playerNumber:= -99
var deviceNumber:= -99

func _init():
	var baseState = State.new(self)
	addState(baseState)

func addState(s: State, _msg:={}):
	##Run interruption code
	if currentState != null:
		var intState = s
		##Get game state from connection
		if intState is GameState_Connection:
			intState = intState.gameState
		currentState.interruptState(intState)
	
	##Add new state to stack
	stateStack.push_front(s)
	currentState = stateStack.front()
	currentState.stateStack = self
	print(str("\nPSS-", playerNumber))
	for state in stateStack:
		if state is GameState_Connection:
			print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
		else:
			print(state.get_script().resource_path.get_file())
	print("\n")
	currentState.enter(_msg)

func resumeCurrentState():
	currentState.resumeState()

func removeState():
	stateStack.pop_front()
	
	if(stateStack.is_empty()):
		print("STACK EMPTY")
	currentState = stateStack.front()
	print(str("\nPSS-", playerNumber))
	for state in stateStack:
		if state is GameState_Connection:
			print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
		else:
			print(state.get_script().resource_path.get_file())
	print("\n")
	
	resumeCurrentState()

func removeGameState():
	#Iterate through stack until finds first Game State.
	var popState = stateStack.pop_front()
	if popState is GameState_Connection:
		#Pop Game State then resume next state.
		currentState = stateStack.front()
		print(str("\nPSS-", playerNumber))
		for state in stateStack:
			if state is GameState_Connection:
				print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
			else:
				print(state.get_script().resource_path.get_file())
		print("\n")
		
		#resumeCurrentState()
	else:
		#Pop each state found along the way.
		removeGameState()

func _unhandled_input(event):
	currentState.handleInput(event)

func _process(delta):
	currentState.update(delta)

func _physics_process(delta):
	currentState.physicsUpdate(delta)
