extends Event
class_name CreateMinigameEvent

var battleManager
var minigame

func _init(eManager, bm, mg):
	super(eManager)
	battleManager = bm
	minigame = mg
	eventName = "Minigame!"

func runEvent():
	var mg = minigame.instantiate()
	mg.battleManager = battleManager
	battleManager.playerUI.minigameZone.add_child(mg)

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
