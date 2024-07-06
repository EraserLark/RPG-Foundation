extends Event
class_name Prompt_Phase

var thisEventManager = EventQueue.new()

var battleUI
var player
var enemy

func _init(eManager, e, p, ui):
	super(eManager)
	
	battleUI = ui
	enemy = e
	player = p
	
	var battleMenu = battleUI.get_node("BattleMenu")
	var battleMenuState = BattleMenu_State.new(StateStack, battleMenu)
	StateStack.addState(battleMenuState)

func resumeEvent():
	finishEvent()

func finishEvent():
	var actionPhase = Action_Phase.new(eventManager, enemy, player, battleUI)
	eventManager.addEvent(actionPhase)
	eventManager.popQueue()
	#queue_free()
