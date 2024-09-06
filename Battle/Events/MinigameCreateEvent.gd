extends Event
class_name CreateMinigameEvent

var battleManager
var playerNumber
var minigame: PackedScene

func _init(playerNum: int, eManager: EventQueue, bm: BattleManager, mg: PackedScene):
	super(eManager)
	battleManager = bm
	playerNumber = playerNum
	minigame = mg
	eventName = "Minigame!"

func runEvent():
	var mg = minigame.instantiate()
	#var mgClass = mg.getClassInstance()
	mg.initialize(PlayerRoster.roster[playerNumber])
	#mg.playerNumber = playerNumber
	#mg.battleManager = battleManager
	
	var playerPanel = PlayerRoster.roster[playerNumber].battleUI.playerPanel
	playerPanel.minigameZone.add_child(mg)
	print("Stall")

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
