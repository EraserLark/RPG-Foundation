extends Event
class_name CreateMinigameEvent

var battleManager
var playerPanel
var minigame

func _init(eManager, bm, mg):
	super(eManager)
	battleManager = bm
	playerPanel = battleManager.battleUI.playerUIRoster[0].playerPanel
	minigame = mg
	eventName = "Minigame!"

func runEvent():
	var mg = minigame.instantiate()
	mg.battleManager = battleManager
	playerPanel.minigameZone.add_child(mg)

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
