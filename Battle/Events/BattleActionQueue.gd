extends EventQueue
class_name BattleActionQueue

var battleManager
var actionPhase

func _init(bm, ap):
	battleManager = bm
	actionPhase = ap

func popQueue():
	checkForStatus()
	super()

func checkForStatus():
	var statuses = actionPhase.unresolvedStatuses
	
	for status in statuses:
		var statusAction = status.runStatus()
		statusAction.eventManager = self
		status.addToEventQueue(self)
	
	actionPhase.unresolvedStatuses.clear()
