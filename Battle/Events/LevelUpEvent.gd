extends Event
class_name LevelUp_Event

var levelUpEQ = EventQueue.new()
var battleManager : BattleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	battleManager.playerEntities[0].entityInfo.levelUp()
	
	battleManager.cutsceneManager.play("LevelUp")
	
	var message: Array[String] = ["[rainbow]LEVEL UP![/rainbow]", str("You are now Level ", battleManager.playerEntities[0].entityInfo.level)]
	
	battleManager.playerEntities[0].playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(levelUpEQ, StateStack, message, battleManager.playerEntities[0].playerPanel)
	
	levelUpEQ.popQueue()

func resumeEvent():
	if(levelUpEQ.queue.is_empty() && levelUpEQ.currentEvent == null):
		finishEvent()
	else:
		levelUpEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
