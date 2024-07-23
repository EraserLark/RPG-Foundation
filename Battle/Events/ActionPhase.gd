extends Phase
class_name Action_Phase

var battleUI
var player
var enemies
var battleManager

var isOver:= false
var unresolvedStatuses: Array[StatusEffect]

var actionEQ: BattleActionQueue

func _init(battlePM, bm):
	super(battlePM)
	battleManager = bm
	enemies = bm.battleRoster.enemies
	player = bm.playerEntities[0]
	battleUI = bm.battleUI
	
	actionEQ = BattleActionQueue.new(battleManager, self)

func runPhase():
	var playerAction = player.localInfo.selectedAction
	if(playerAction.actionMinigame != null):
		var minigameEvent = CreateMinigameEvent.new(actionEQ, battleManager, playerAction.actionMinigame)
		actionEQ.addEvent(minigameEvent)
	playerAction.eventManager = actionEQ
	playerAction.sender = player
	actionEQ.queue.append(playerAction)
	
	for enemy in battleManager.battleRoster.enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = actionEQ
		enemyAction.sender = enemy
		enemyAction.target = player
		actionEQ.queue.append(enemyAction)
	
	unresolvedStatuses = battleManager.statusRoster.duplicate()
	
	actionEQ.popQueue()

func resumePhase():
	if(actionEQ.queue.is_empty() && actionEQ.currentEvent == null):
		finishPhase()
	else:
		actionEQ.currentEvent.resumeEvent()

func battleOver():
	actionEQ.queue.clear()
	#var finishPhase = Finish_Phase.new(eventManager, battleManager)
	#eventManager.addEvent(finishPhase)
	isOver = true

func finishPhase():
	if(!isOver):
		battleManager.updateTurnCount()
	
	super()

func cleanPhase():
	actionEQ.queue.clear()
