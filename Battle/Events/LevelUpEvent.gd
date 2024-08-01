extends Event
class_name LevelUp_Event

var levelUpEQ = EventQueue.new()
var battleManager : BattleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	battleManager.playerEntities[0].localInfo.levelUp()
	
	battleManager.cutsceneManager.play("LevelUp")
	
	var message: Array[String] = ["[rainbow]LEVEL UP![/rainbow]", str("You are now Level ", battleManager.playerEntities[0].localInfo.level)]
	
	battleManager.playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(levelUpEQ, StateStack, message, battleManager.playerPanel)
	
	levelUpEQ.popQueue()

func resumeEvent():
	if(levelUpEQ.queue.is_empty() && levelUpEQ.currentEvent == null):
		finishEvent()
	else:
		levelUpEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
