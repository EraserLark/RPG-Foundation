extends Event
class_name VictoryEvent

var battleManager

var victoryEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	var playerEntity = battleManager.playerEntities[0]
	var playerInfo = playerEntity.entityInfo
	playerInfo.xp += battleManager.xpBank
	
	var message : Array[String] = [str("You win! Gained ", battleManager.xpBank, "xp!")]
	#var textbox = battleManager.battleUI.textbox
	
	playerEntity.entityUI.playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(victoryEQ, GameStateStack.stack, message, battleManager.battleUI.tbContainer)
	
	if(playerInfo.xp >= playerInfo.nextLevelCost):
		var lvlUp = LevelUp_Event.new(playerEntity, eventManager, battleManager)
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
