extends Event
class_name VictoryEvent

var battleManager

var victoryEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	var playerInfo = battleManager.playerEntities[0].localInfo
	playerInfo.xp += battleManager.xpBank
	
	var message = str("You win! Gained ", battleManager.xpBank, "xp!")
	var textbox = battleManager.battleUI.textbox
	
	Textbox_State.createEvent(victoryEQ, StateStack, textbox, message)
	
	if(playerInfo.xp >= playerInfo.nextLevelCost):
		var lvlUp = LevelUp_Event.new(eventManager, battleManager)
		victoryEQ.addEvent(lvlUp)
	
	Cutscene_State.createEvent(eventManager, battleManager, BattleOutro)
	
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
