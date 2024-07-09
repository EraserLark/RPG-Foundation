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
		status.checkStatusCount()
		
		if status == null:
			return
		
		var statusAction = status.runStatus()
		statusAction.eventManager = self
		status.addToEventQueue(self)
		
		actionPhase.unresolvedStatuses.erase(status)
		#actionEventQueue.queue.append(statusAction)
