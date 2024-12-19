extends Node
class_name StateStack

var stateStack: Array[State]
var currentState: State = null
var playerEntity: PlayerEntity
var playerInput: DeviceInput
var localPlayerNumber:= -99
var localDeviceNumber:= -99

func _init(pe: PlayerEntity):
	playerEntity = pe
	playerInput = playerEntity.input
	localPlayerNumber = playerEntity.rosterNumber
	localDeviceNumber = playerEntity.deviceNumber
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
	#print(str("\nPSS-", playerEntity.rosterNumber))
	#for state in stateStack:
		#if state is GameState_Connection:
			#print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
		#else:
			#print(state.get_script().resource_path.get_file())
	#print("\n")
	
	currentState.enter(_msg)

func resumeCurrentState():
	currentState.resumeState()

func removeState():
	var discardedState = stateStack.pop_front()
	
	if(stateStack.is_empty()):
		print("STACK EMPTY")
	currentState = stateStack.front()
	#print(str("\nPSS-", playerEntity.rosterNumber))
	#for state in stateStack:
		#if state is GameState_Connection:
			#print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
		#else:
			#print(state.get_script().resource_path.get_file())
	#print("\n")
	resumeCurrentState()

func removeGameState():
	#Iterate through stack until finds first Game State.
	var popState = stateStack.pop_front()
	if popState is GameState_Connection:
		#Pop Game State then resume next state.
		currentState = stateStack.front()
		#print(str("\nPSS-", playerEntity.rosterNumber))
		#for state in stateStack:
			#if state is GameState_Connection:
				#print(str(state.get_script().resource_path.get_file()), " -- ", state.gameState.get_script().resource_path.get_file())
			#else:
				#print(state.get_script().resource_path.get_file())
		#print("\n")
	else:
		#Pop each state found along the way.
		removeGameState()

func changeRosterNumber(newNumber: int):
	localPlayerNumber = newNumber
	for state in stateStack:
		state.changeRosterNum(localPlayerNumber)

func changeDeviceNumber(newNumber: int):
	localDeviceNumber = newNumber
	for state in stateStack:
		state.changeDeviceNum(localDeviceNumber)

func _unhandled_input(event):
	if playerInput.is_keyboard():
		if event.device <= 0:
			currentState.handleInput(event)
	elif event.device == playerInput.device:
		currentState.handleInput(event)

func _process(delta):
	currentState.update(delta)

func _physics_process(delta):
	currentState.physicsUpdate(delta)
