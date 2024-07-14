extends Event
class_name Finish_Phase

var battleUI
var battleManager

var finshEQ = EventQueue.new()

func _init(battleEQ, bm):
	super(battleEQ)
	battleUI = bm.battleUI
	battleManager = bm

func runEvent():
	var textbox = battleUI.get_node("Textbox")
	
	var message = ""
	if(battleManager.playerEntities.size() <= 0):
		message = "You Lose :("
	elif(battleManager.enemyEntities.size() <= 0):
		message = "You win!! :D"
	
	Textbox_State.createEvent(finshEQ, StateStack, textbox, message)
	
	Cutscene_State.createEvent(finshEQ, battleManager, BattleOutro)
	
	finshEQ.queueEmpty.connect(resumeEvent)
	print(finshEQ.queueEmpty.is_connected(self.resumeEvent))
	finshEQ.popQueue()

func resumeEvent():
	if(finshEQ.queue.is_empty() && finshEQ.currentEvent == null):
		finishEvent()
	else:
		finshEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
