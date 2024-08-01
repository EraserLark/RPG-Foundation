extends Event
class_name UpdateTurn

var battleManager
var statusRoster

var statusUpdateEQ = EventQueue.new()

func _init(eManager:EventQueue, bm:BattleManager):
	super(eManager)
	battleManager = bm
	statusRoster = bm.actionPhase.statusRoster

func runEvent():
	var currentCount = battleManager.updateTurnCount()
	
	var _statusRoster = statusRoster.duplicate()
	for status in _statusRoster:
		var readyToEnd = status.checkStatusCount(currentCount)
		if(readyToEnd):
			var message: Array[String] = [str(status.status_name, " has ended!")]
			Textbox_State.createEvent(statusUpdateEQ, StateStack, message, battleManager.battleUI.tbContainer)
			status.endStatus()
	
	statusUpdateEQ.popQueue()

func resumeEvent():
	if(statusUpdateEQ.queue.is_empty() && statusUpdateEQ.currentEvent == null):
		finishEvent()
	else:
		statusUpdateEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
