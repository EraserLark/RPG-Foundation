extends State
class_name MinigameState

var minigameManager
var atkBoost:= 0
var battleManager: BattleManager
var playerPanel: PlayerPanel_Battle

func _init(sStack: StateStack, mg, bm):
	super(sStack)
	minigameManager = mg
	battleManager = bm
	playerPanel = battleManager.battleUI.playerUIRoster[0].playerPanel
	
	sStack.addState(self)

func handleInput(_event : InputEvent):
	minigameManager.handleInput(_event)

func enter(_msg := {}):
	if(battleManager != null):
		playerPanel.showMinigame(true)
 
func update(_delta : float):
	minigameManager.update(_delta)	

func physicsUpdate(_delta : float):
	minigameManager.physicsUpdate(_delta)

func resumeState():
	#Give attack boost to the attack the player selected
	battleManager.playerEntities[0].entityInfo.selectedAction.bonusDamage = atkBoost
	exit()

func exit():
	minigameManager.endMinigame()
	playerPanel.showMinigame(false)
	super()
