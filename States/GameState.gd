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
	pass

func stackResume():
	pass

func stackExit():
	exit(-99)


##PLAYER - Run when entering each scene tree (1-8 times)
func enter(playerNum: int, _msg:= {}):
	pass

func resumeState(playerNum: int):
	pass

func exit(playerNum: int):
	for stack in playerStacks:
		stack.removeGameState()


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
