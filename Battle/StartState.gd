extends Event
class_name Start_Phase

signal moveToPromptPhase
signal send_message(message : String)
signal endBattle()

var ui
var thisEventManager : EventQueue = EventQueue.new()

func _init(eManager, UI):
	super(eManager)
	ui = UI

func runEvent():
	var textbox = ui.get_node("Textbox")
	var tbEvent = TB_Event.new(thisEventManager, textbox, "Battle Start :O")
	thisEventManager.addEvent(tbEvent)
	thisEventManager.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	var battleMenu = ui.get_node("BattleMenu")
	var promptPhase = Prompt_Phase.new(eventManager, battleMenu)
	eventManager.addEvent(promptPhase)
	super()
