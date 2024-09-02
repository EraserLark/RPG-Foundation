extends GameState
class_name GameState_Overworld

##PLAYER - Run when entering each scene tree (1-8 times)
func enter(playerNum: int, _msg:= {}):
	#Create Player_EnterActor state
	resumeState(playerNum)

##PLAYER - Runs 1-8 times
func resumeState(playerNum: int):
	#Add PlayerActive state to Player State Stack
	var pStateStack = PlayerRoster.roster[playerNum].playerStateStack
	var playerActive = Player_Active.new(pStateStack, PlayerRoster.roster[playerNum].entityActor)
	pStateStack.addState(playerActive)
	
	##Then add next active Game State to Player State Stack (if any)
	#<To Fill in>

##SELF - Runs once
##This class' implementation should only run when quitting the game
func exit(playerNum: int):
	super(playerNum)
