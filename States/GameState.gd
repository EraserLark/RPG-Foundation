extends State
class_name GameState

var playerStacks: Array[StateStack]

##SELF - Run once when created
func _init(sStack: StateStack):
	if sStack != null:
		printerr("Pass null into GameState. The state stack passed will not be used.")
	
	for playerEntity in PlayerRoster.getRoster():
		playerStacks.append(playerEntity.playerStateStack)
		playerEntity.playerStateStack.addState(self)

##PLAYER - Run when entering each scene tree (1-8 times)
func enter(_msg:= {}):
	pass

##PLAYER - Runs 1-8 times
func resumeState():
	pass

##SELF - Runs once
func exit():
	for stack in playerStacks:
		stack.removeGameState()


##All of the Player state stacks should be connected & feeding to these functions
##PLAYER
func handleInput(_event: InputEvent):
	##If you give x input with your device number, let me know
	pass

##PLAYER
func update(_delta: float):
	pass

##PLAYER
func physicsUpdate(_delta: float):
	pass


class EventClass:
	pass
