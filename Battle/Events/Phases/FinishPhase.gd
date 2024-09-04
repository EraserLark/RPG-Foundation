extends Phase
class_name Finish_Phase

var battleUI
var battleManager

var finishEQ = EventQueue.new()

func _init(battlePM, bm):
	super(battlePM)
	battleUI = bm.battleUI
	battleManager = bm

func runPhase():
	var resultEvent : Event
	
	if(!battleManager.battleRoster.checkPlayersAlive()):
		resultEvent = DefeatEvent.new(finishEQ, battleManager)
	elif(!battleManager.battleRoster.checkEnemiesAlive()):
		resultEvent = VictoryEvent.new(finishEQ, battleManager)
	
	finishEQ.addEvent(resultEvent)
	
	finishEQ.popQueue()

func resumePhase():
	if(finishEQ.queue.is_empty() && finishEQ.currentEvent == null):
		finishPhase()
	else:
		finishEQ.currentEvent.resumeEvent()

func finishPhase():
	#for player in battleManager.battleRoster.players:
		#PlayerRoster.roster[0] = player.localInfo.duplicate_deep_workaround()
	print("Stall")
	super()
