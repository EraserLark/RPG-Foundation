extends Event
class_name Start_Phase

signal moveToPromptPhase
signal send_message(message : String)
signal endBattle()

var enemy
var player
var battleUI
var thisEventManager : EventQueue = EventQueue.new()

func _init(eManager, e, p, ui):
	super(eManager)
	battleUI = ui
	enemy = e
	player = p

func runEvent():
	var textbox = battleUI.get_node("Textbox")
	var tbEvent = TB_Event.new(thisEventManager, textbox, "Battle Start :O")
	thisEventManager.addEvent(tbEvent)
	thisEventManager.popQueue()

func resumeEvent():
	finishEvent()

func finishEvent():
	var promptPhase = Prompt_Phase.new(eventManager, enemy, player, battleUI)
	eventManager.addEvent(promptPhase)
	super()
