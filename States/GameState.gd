extends Node
class_name GameState

var playerStacks: Array[StateStack]

##SELF - Run once when created
func _init(_msg := {}):
	for playerEntity in PlayerRoster.getActiveRoster():
		playerStacks.append(playerEntity.playerStateStack)
	
	GameStateStack.addGameState(self, _msg)

##SELF - Runs once
func stackEnter(_msg := {}):
	#Run each player's enter (game state enter by extentsion)
	for playerEntity in PlayerRoster.getActiveRoster():
		var connectionState = GameState_Connection.new(playerEntity.playerStateStack, self)
		playerEntity.playerStateStack.addState(connectionState)	#Enters game state roundabout

func stackResume():
	for playerEntity in PlayerRoster.getActiveRoster():
		playerEntity.playerStateStack.resumeCurrentState()

func stackExit():
	exit(-99)


##PLAYER - Run when entering each scene tree (1-8 times)
func enter(playerNum: int, _msg:= {}):
	pass

func resumeState(playerNum: int):
	pass

func exit(playerNum: int):
	GameStateStack.removeState()
	#for stack in playerStacks:
		#stack.removeGameState()


##All of the Player state stacks should be connected & feeding to these functions
##PLAYER
func handleInput(playerNum: int, _event: InputEvent):
	##Checks if event number matches player device number before calling (in GameState_Connection)
	pass

##PLAYER
func update(playerNum: int, _delta: float):
	pass

##PLAYER
func physicsUpdate(playerNum: int, _delta: float):
	pass


class EventClass:
	pass
