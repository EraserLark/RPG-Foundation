extends Event
class_name Start_Phase

var battleUI
var battleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	battleUI = bm.battleUI

func runEvent():
	var textbox = battleUI.get_node("Textbox")
	var tbState = Textbox_State.new(StateStack, textbox, "Battle Time!!")
	StateStack.addState(tbState)

func resumeEvent():
	finishEvent()

func finishEvent():
	var promptPhase = Prompt_Phase.new(eventManager, battleManager)
	eventManager.addEvent(promptPhase)
	super()
