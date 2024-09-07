extends Node #extends Entity
class_name StatusEffect

var battleManager: BattleManager
var actionPhase: GameState_ActionPhase
var statusRoster
var unresolvedStatuses

var status_name: String
var turnCountLimit: int
var startingTurn: int
var statusAction: Action
var target: Entity

func _init(sn, tc, tg, bm, sr, us):
	status_name = sn
	turnCountLimit = tc
	target = tg
	battleManager = bm
	actionPhase = bm.actionPhase
	statusRoster = sr
	unresolvedStatuses = us
	
	startingTurn = battleManager.turnCount

func runStatus():
	return statusAction

func checkStatusCount(battleTurnCount):
	if(battleTurnCount >= (turnCountLimit + startingTurn)):
		#endStatus()
		return true
	else:
		return false

func addToEventQueue(_eq):
	pass

func revertStatus():
	pass

func endStatus():
	#Recovery animation + sfx
	revertStatus()
	target.statusEffects.erase(self)
	statusRoster.erase(self)
	unresolvedStatuses.erase(self)
	actionPhase.actionEQ.queue.erase(statusAction)
	
	#var message = str(status_name, " has ended!")
	#var endTB = Textbox_State.new(StateStack, battleManager.battleUI.textbox, message)
	#StateStack.addState(endTB)
	
	queue_free()
