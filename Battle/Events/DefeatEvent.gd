extends Event
class_name DefeatEvent

var battleManager

var defeatEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	var message: Array[String] = ["You lose!"]
	#var textbox = battleManager.battleUI.textbox
	
	battleManager.playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(defeatEQ, StateStack, message, battleManager.battleUI.tbContainer)
	
	Cutscene_State.createEvent(defeatEQ, battleManager, BattleOutro)
	
	defeatEQ.popQueue()

func resumeEvent():
	if(defeatEQ.queue.is_empty() && defeatEQ.currentEvent == null):
		finishEvent()
	else:
		defeatEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
