extends Event
class_name VictoryEvent

var battleManager

var victoryEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	GameState_Cutscene.createEvent(eventManager, battleManager, ResultText)
	
	GameState_BattleResults.createEvent(eventManager, battleManager)
	
	GameState_Cutscene.createEvent(eventManager, battleManager, BattleOutro)
	
	victoryEQ.popQueue()

func resumeEvent():
	if(victoryEQ.queue.is_empty() && victoryEQ.currentEvent == null):
		finishEvent()
	else:
		victoryEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
