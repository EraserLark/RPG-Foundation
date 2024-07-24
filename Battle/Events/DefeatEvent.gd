extends Event
class_name DefeatEvent

var battleManager

var defeatEQ := EventQueue.new()

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	var message = "You lose!"
	var textbox = battleManager.battleUI.textbox
	
	Textbox_State.createEvent(defeatEQ, StateStack, textbox, message)
	
	Cutscene_State.createEvent(defeatEQ, battleManager, BattleOutro)
	
	defeatEQ.popQueue()

func resumeEvent():
	if(defeatEQ.queue.is_empty() && defeatEQ.currentEvent == null):
		finishEvent()
	else:
		defeatEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
