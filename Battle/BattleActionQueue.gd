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
	#Check counts in statuses to remove overdue statuses
	var dup = actionPhase.unresolvedStatuses.duplicate()
	
	for status in dup:
		status.checkStatusCount()
	
	#Grab remaining statuses, then executed them
	var statuses = actionPhase.unresolvedStatuses
	
	for status in statuses:
		var statusAction = status.runStatus()
		statusAction.eventManager = self
		status.addToEventQueue(self)
	
	actionPhase.unresolvedStatuses.clear()
