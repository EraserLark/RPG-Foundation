extends State
class_name MinigameState

var minigameManager
var atkBoost:= 0
var battleManager : BattleManager

func _init(sStack : StateStack, mg, bm):
	super(sStack)
	minigameManager = mg
	battleManager = bm
	
	sStack.addState(self)

func handleInput(_event : InputEvent):
	minigameManager.handleInput(_event)

func enter(_msg := {}):
	if(battleManager != null):
		battleManager.playerUI.showMinigame(true)
 
func update(_delta : float):
	minigameManager.update(_delta)	

func physicsUpdate(_delta : float):
	minigameManager.physicsUpdate(_delta)

func resumeState():
	#Give attack boost to the attack the player selected
	battleManager.playerEntities[0].localInfo.selectedAction.bonusDamage = atkBoost
	exit()

func exit():
	minigameManager.endMinigame()
	battleManager.playerUI.showMinigame(false)
	super()

