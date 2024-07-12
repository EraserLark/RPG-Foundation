extends Event
class_name Action_Phase

var battleUI
var player
var enemies
var battleManager

var isOver := false
var unresolvedStatuses : Array[StatusEffect]

var actionEQ : BattleActionQueue

func _init(battleEQ, bm):
	super(battleEQ)
	battleManager = bm
	enemies = bm.battleRoster.enemies
	player = bm.playerEntity
	battleUI = bm.battleUI
	
	actionEQ = BattleActionQueue.new(battleManager, self)
	actionEQ.queueEmpty.connect(finishEvent)

func runEvent(_msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.actionEQ
	playerAction.sender = player
	actionEQ.queue.append(playerAction)
	
	for enemy in battleManager.battleRoster.enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = self.actionEQ
		enemyAction.sender = enemy
		enemyAction.target = player
		actionEQ.queue.append(enemyAction)
	
	unresolvedStatuses = battleManager.statusRoster.duplicate()
	
	actionEQ.popQueue()

func resumeEvent():
	if(actionEQ.queue.front() == actionEQ.currentEvent):
		finishEvent()
	else:
		actionEQ.currentEvent.resumeEvent()

func battleOver():
	actionEQ.queue.clear()
	var finishPhase = Finish_Phase.new(eventManager, battleManager)
	eventManager.addEvent(finishPhase)
	isOver = true

func finishEvent():
	eventManager.queueEmpty.disconnect(finishEvent)
	
	if(!isOver):
		battleManager.updateTurnCount()
		var promptPhase = Prompt_Phase.new(eventManager, battleManager)
		eventManager.addEvent(promptPhase)
	
	super()
