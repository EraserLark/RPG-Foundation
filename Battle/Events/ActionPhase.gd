extends Event
class_name Action_Phase

var battleUI
var player
var enemy
var battleManager
var isOver := false

var actionEventQueue := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	enemy = bm.enemyEntity
	player = bm.playerEntity
	battleUI = bm.battleUI
	
	actionEventQueue.queueEmpty.connect(finishEvent)

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.actionEventQueue
	playerAction.sender = player
	playerAction.target = enemy
	
	var enemyAction = enemy.chooseAttack()
	enemyAction.eventManager = self.actionEventQueue
	enemyAction.sender = enemy
	enemyAction.target = player
	
	actionEventQueue.queue.append(playerAction)
	actionEventQueue.queue.append(enemyAction)
	
	var statuses = battleManager.statusRoster
	for status in statuses:
		var statusAction = status.runStatus()
		statusAction.eventManager = self.actionEventQueue
		actionEventQueue.queue.append(statusAction)
		status.checkStatusCount()
	
	actionEventQueue.popQueue()

func resumeEvent():
	if(actionEventQueue.queue.front() == actionEventQueue.currentEvent):
		finishEvent()
	else:
		actionEventQueue.currentEvent.resumeEvent()

func battleOver():
	actionEventQueue.queue.clear()
	var finishPhase = Finish_Phase.new(eventManager, battleManager)
	eventManager.addEvent(finishPhase)
	isOver = true

func finishEvent():
	if(!isOver):
		battleManager.updateTurnCount()
		var promptPhase = Prompt_Phase.new(eventManager, battleManager)
		eventManager.addEvent(promptPhase)
	
	eventManager.queueEmpty.disconnect(finishEvent)
	super()
