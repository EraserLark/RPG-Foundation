extends Event
class_name Finish_Phase

var battleUI
var battleManager

func _init(eManager, bm):
	super(eManager)
	battleUI = bm.battleUI
	battleManager = bm

func runEvent():
	var textbox = battleUI.get_node("Textbox")
	
	var message = ""
	if(battleManager.playerEntity.localPlayer.hp <= 0):
		message = "You Lose :("
	elif(battleManager.enemyEntities.size() <= 0):
		message = "You win!! :D"
	
	var tbEvent = TB_Event.new(eventManager, StateStack, textbox, message)
	eventManager.addEvent(tbEvent)
	
	var cutsceneEvent = CutsceneEvent.new(eventManager, battleManager, BattleOutro)
	eventManager.addEvent(cutsceneEvent)
	
	eventManager.queueEmpty.connect(resumeEvent)
	print(eventManager.queueEmpty.is_connected(self.resumeEvent))
	eventManager.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	set_process_input(false)
	StateStack.removeState()
	battleManager.queue_free()
