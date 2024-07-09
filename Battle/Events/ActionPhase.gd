extends Event
class_name Action_Phase

var battleUI
var player
var enemy
var battleManager

var isOver := false
var unresolvedStatuses : Array[StatusEffect]

var actionEventQueue

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	enemy = bm.enemyEntity
	player = bm.playerEntity
	battleUI = bm.battleUI
	
	actionEventQueue = BattleActionQueue.new(battleManager, self)
	actionEventQueue.queueEmpty.connect(finishEvent)

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.actionEventQueue
	playerAction.sender = player
	if(playerAction.target == null):
		playerAction.target = enemy
	
	var enemyAction = enemy.chooseAttack()
	enemyAction.eventManager = self.actionEventQueue
	enemyAction.sender = enemy
	enemyAction.target = player
	
	actionEventQueue.queue.append(playerAction)
	actionEventQueue.queue.append(enemyAction)
	
	unresolvedStatuses = battleManager.statusRoster
	
	#var statuses = battleManager.statusRoster
	#for status in statuses:
		#status.checkStatusCount()
		#
		#if status == null:
			#return
		#
		#var statusAction = status.runStatus()
		#statusAction.eventManager = self.actionEventQueue
		#status.addToEventQueue(eventManager)
		##actionEventQueue.queue.append(statusAction)
	
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
