extends Event
class_name Finish_Phase

var battleUI
var battleManager

var finishEQ = EventQueue.new()

func _init(battleEQ, bm):
	super(battleEQ)
	battleUI = bm.battleUI
	battleManager = bm

func runEvent():
	var resultEvent : Event
	
	if(battleManager.playerEntities.size() <= 0):
		resultEvent = VictoryEvent.new(finishEQ, battleManager)
	elif(battleManager.enemyEntities.size() <= 0):
		resultEvent = DefeatEvent.new(finishEQ, battleManager)
	
	finishEQ.addEvent(resultEvent)
	
	#Textbox_State.createEvent(finishEQ, StateStack, textbox, message)
	#
	#Cutscene_State.createEvent(finishEQ, battleManager, BattleOutro)
	
	finishEQ.queueEmpty.connect(resumeEvent)
	print(finishEQ.queueEmpty.is_connected(self.resumeEvent))
	finishEQ.popQueue()

func resumeEvent():
	if(finishEQ.queue.is_empty() && finishEQ.currentEvent == null):
		finishEvent()
	else:
		finishEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
