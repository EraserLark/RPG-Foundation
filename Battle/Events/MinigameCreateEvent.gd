extends Event
class_name CreateMinigameEvent

var battleManager
var playerNumber
var minigame

func _init(playerNum: int, eManager: EventQueue, bm: BattleManager, mg):
	super(eManager)
	battleManager = bm
	playerNumber = playerNum
	minigame = mg
	eventName = "Minigame!"

func runEvent():
	var mg = minigame.instantiate()
	mg.playerNumber = playerNumber
	mg.battleManager = battleManager
	
	var playerPanel = PlayerRoster.roster[0].battleUI.playerPanel
	playerPanel.minigameZone.add_child(mg)

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
