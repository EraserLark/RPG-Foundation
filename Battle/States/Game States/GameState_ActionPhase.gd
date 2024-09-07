extends GameState
class_name GameState_ActionPhase

var phaseManager: GameState_PhaseManager
var battleManager
var livingPlayers
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
	for playerEntity in PlayerRoster.getLivingRoster():
		var connectionState = GameState_Connection.new(playerEntity.playerStateStack, self)
		playerEntity.playerStateStack.addState(connectionState)	#Enters game state roundabout
	
	enemies = battleManager.enemyRoster.enemies
	livingPlayers = PlayerRoster.getLivingRoster()
	
	for player in livingPlayers:
		var playerAction = player.entityInfo.selectedAction
		if(playerAction.actionMinigame != null):
			var minigameEvent = CreateMinigameEvent.new(player.rosterNumber, actionEQ, battleManager, playerAction.actionMinigame)
			actionEQ.addEvent(minigameEvent)
		playerAction.eventManager = actionEQ
		playerAction.sender = player
		actionEQ.queue.append(playerAction)
	
	for enemy in enemies:
		var enemyAction = enemy.chooseAttack()
		enemyAction.eventManager = actionEQ
		enemyAction.sender = enemy
		enemyAction.target = livingPlayers.pick_random()
		actionEQ.queue.append(enemyAction)
	
	unresolvedStatuses = statusRoster.duplicate()
	
	actionEQ.popQueue()

#Coming out of minigame states
func resumeState(playerNum: int):
	decideNextStep()

func stackResume():
	decideNextStep()

func decideNextStep():
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
	##Remove gamestate from all stacks, but do not delete game state
	for playerEntity in PlayerRoster.getLivingRoster():
		playerEntity.playerStateStack.removeGameState()
	
	var gameStateStack = GameStateStack.gameStateStack
	gameStateStack.pop_front()
	if(gameStateStack.is_empty()):
		print("STACK EMPTY")
	GameStateStack.frontGameState = gameStateStack.front()
	for state in gameStateStack:
		print(state.get_script().resource_path.get_file())
	print("\n")

	phaseManager.phaseFinished()

func cleanPhase():
	actionEQ.queue.clear()
	
func battleOver():
	actionEQ.queue.clear()
	battleManager.battleIsOver = true
