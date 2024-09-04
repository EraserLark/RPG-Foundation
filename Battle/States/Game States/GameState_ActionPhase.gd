extends GameState
class_name GameState_ActionPhase

var phaseManager: GameState_PhaseManager
var battleManager
var playerEntities
var enemies

var turnUpdated:= false

var actionEQ: BattleActionQueue
var statusRoster: Array[StatusEffect]
var unresolvedStatuses: Array[StatusEffect]

func _init(pm: GameState_PhaseManager, bm: BattleManager, _msg := {}):
	phaseManager = pm
	battleManager = bm
	
	actionEQ = BattleActionQueue.new(battleManager, self)

func stackEnter(_msg:= {}):
	enemies = battleManager.battleRoster.enemies
	playerEntities = PlayerRoster.getActiveRoster()
	
	for player in playerEntities:
		var playerAction = player.entityInfo.selectedAction
		if(playerAction.actionMinigame != null):
			var minigameEvent = CreateMinigameEvent.new(player.rosterNumber, actionEQ, battleManager, playerAction.actionMinigame)
			actionEQ.addEvent(minigameEvent)
		playerAction.eventManager = actionEQ
		playerAction.sender = player
		actionEQ.queue.append(playerAction)
	
	for enemy in battleManager.battleRoster.enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = actionEQ
		enemyAction.sender = enemy
		enemyAction.target = playerEntities.pick_random()
		actionEQ.queue.append(enemyAction)
	
	unresolvedStatuses = statusRoster.duplicate()
	
	actionEQ.popQueue()

func stackResume():
	if(actionEQ.queue.is_empty() && actionEQ.currentEvent == null):
		if(!turnUpdated):
			turnUpdated = true
			var turnEvent = UpdateTurn.new(actionEQ, battleManager)
			actionEQ.addEvent(turnEvent)
			actionEQ.popQueue()
			
		elif(turnUpdated):
			turnUpdated = false
			stackExit()
			
	else:
		actionEQ.currentEvent.resumeEvent()

func stackExit():
	super()
	phaseManager.phaseFinished()	#??

func cleanPhase():
	actionEQ.queue.clear()
	
func battleOver():
	actionEQ.queue.clear()
	battleManager.battleIsOver = true
