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
	
	var message : Array[String] = [str("You win! Gained ", battleManager.xpBank, "xp!")]
	#var textbox = battleManager.battleUI.textbox
	
	battleManager.playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(victoryEQ, StateStack, message, battleManager.battleUI.tbContainer)
	
	if(playerInfo.xp >= playerInfo.nextLevelCost):
		var lvlUp = LevelUp_Event.new(eventManager, battleManager)
		victoryEQ.addEvent(lvlUp)
	
	Cutscene_State.createEvent(eventManager, battleManager, BattleOutro)
	
	victoryEQ.popQueue()

func resumeEvent():
	if(victoryEQ.queue.is_empty() && victoryEQ.currentEvent == null):
		finishEvent()
	else:
		victoryEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
