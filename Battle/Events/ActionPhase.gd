extends Event
class_name Action_Phase

var battleUI
var player
var enemies
var battleManager

var isOver := false
var unresolvedStatuses : Array[StatusEffect]

var actionEventQueue

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	enemies = bm.battleRoster.enemies
	player = bm.playerEntity
	battleUI = bm.battleUI
	
	actionEventQueue = BattleActionQueue.new(battleManager, self)
	actionEventQueue.queueEmpty.connect(finishEvent)

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.actionEventQueue
	playerAction.sender = player
	#if(playerAction.target == null):
		#playerAction.target = enemy
	actionEventQueue.queue.append(playerAction)
	
	for enemy in battleManager.battleRoster.enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = self.actionEventQueue
		enemyAction.sender = enemy
		enemyAction.target = player
		actionEventQueue.queue.append(enemyAction)
	
	unresolvedStatuses = battleManager.statusRoster.duplicate()
	
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
