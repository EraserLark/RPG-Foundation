extends GameState
class_name GameState_FinishPhase

var phaseManager: GameState_PhaseManager
var battleManager

var finishEQ = EventQueue.new()

func _init(pm: GameState_PhaseManager, bm: BattleManager):
	phaseManager = pm
	battleManager = bm

func stackEnter(_msg := {}):
	var resultEvent : Event
	
	if(!battleManager.battleRoster.checkPlayersAlive()):
		resultEvent = DefeatEvent.new(finishEQ, battleManager)
	elif(!battleManager.battleRoster.checkEnemiesAlive()):
		resultEvent = VictoryEvent.new(finishEQ, battleManager)
	
	finishEQ.addEvent(resultEvent)
	
	finishEQ.popQueue()

func stackResume():
	if(finishEQ.queue.is_empty() && finishEQ.currentEvent == null):
		stackExit()
	else:
		finishEQ.currentEvent.resumeEvent()

func stackExit():
	super()
	phaseManager.phaseFinished()
