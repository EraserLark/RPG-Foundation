extends Event
class_name Start_Phase

signal moveToPromptPhase
signal send_message(message : String)
signal endBattle()

var battleUI
var thisEventManager : EventQueue = EventQueue.new()
var battleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	battleUI = bm.battleUI

func runEvent():
	var textbox = battleUI.get_node("Textbox")
	var tbEvent = TB_Event.new(thisEventManager, textbox, "Battle Start :O")
	thisEventManager.addEvent(tbEvent)
	thisEventManager.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	var promptPhase = Prompt_Phase.new(eventManager, battleManager)
	eventManager.addEvent(promptPhase)
	super()
