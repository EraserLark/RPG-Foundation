extends Event
class_name Start_Phase

var battleUI
var battleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	battleUI = bm.battleUI

func runEvent():
	var introCutscene = BattleIntro.new(StateStack, battleManager.cutsceneManager, battleManager)
	StateStack.addState(introCutscene)

func resumeEvent():
	finishEvent()

func finishEvent():
	var promptPhase = Prompt_Phase.new(eventManager, battleManager)
	eventManager.addEvent(promptPhase)
	super()
