extends Phase
class_name Action_Phase

#var battleUI
var player
var enemies
var battleManager

var turnUpdated:= false

var actionEQ: BattleActionQueue
var statusRoster: Array[StatusEffect]
var unresolvedStatuses: Array[StatusEffect]

func _init(battlePM, bm):
	super(battlePM)
	battleManager = bm
	enemies = bm.battleRoster.enemies
	player = bm.playerEntities[0]
	#battleUI = bm.battleUI
	
	actionEQ = BattleActionQueue.new(battleManager, self)

func runPhase():
	#var playerAction = player.entityInfo.selectedAction
	#if(playerAction.actionMinigame != null):
		#var minigameEvent = CreateMinigameEvent.new(player.entityInfo.playerNumber, actionEQ, battleManager, playerAction.actionMinigame)
		#actionEQ.addEvent(minigameEvent)
	#playerAction.eventManager = actionEQ
	#playerAction.sender = player
	#actionEQ.queue.append(playerAction)
	
	for enemy in battleManager.battleRoster.enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = actionEQ
		enemyAction.sender = enemy
		enemyAction.target = player
		actionEQ.queue.append(enemyAction)
	
	unresolvedStatuses = statusRoster.duplicate()
	
	actionEQ.popQueue()

func resumePhase():
	if(actionEQ.queue.is_empty() && actionEQ.currentEvent == null):
		if(!turnUpdated):
			turnUpdated = true
			var turnEvent = UpdateTurn.new(actionEQ, battleManager)
			actionEQ.addEvent(turnEvent)
			actionEQ.popQueue()
			
		elif(turnUpdated):
			turnUpdated = false
			finishPhase()
			
	else:
		actionEQ.currentEvent.resumeEvent()

func battleOver():
	actionEQ.queue.clear()
	battleManager.battleIsOver = true

func finishPhase():
	super()

func cleanPhase():
	actionEQ.queue.clear()
