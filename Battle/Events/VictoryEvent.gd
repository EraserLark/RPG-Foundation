extends Event
class_name VictoryEvent

var battleManager

var victoryEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	battleManager.playerEntities[0].localInfo.xp += battleManager.xpBank
	
	var message = str("You win! Gained ", battleManager.xpBank, "xp!")
	var textbox = battleManager.battleUI.textbox
	
	Textbox_State.createEvent(victoryEQ, StateStack, textbox, message)
	
	Cutscene_State.createEvent(victoryEQ, battleManager, BattleOutro)
	
	victoryEQ.queueEmpty.connect(resumeEvent)
	print(victoryEQ.queueEmpty.is_connected(self.resumeEvent))
	victoryEQ.popQueue()

func resumeEvent():
	if(victoryEQ.queue.is_empty() && victoryEQ.currentEvent == null):
		finishEvent()
	else:
		victoryEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
