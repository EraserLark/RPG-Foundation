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
	if(battleManager.enemyEntity.localEnemy.hp <= 0):
		message = "You win!! :D"
	elif(battleManager.playerEntity.localPlayer.hp <= 0):
		message = "You Lose :("
	
	var tbState = Textbox_State.new(StateStack, textbox, message)
	StateStack.addState(tbState)

func resumeEvent():
	finishEvent()

func finishEvent():
	set_process_input(false)
	StateStack.removeState()
	battleManager.queue_free()
