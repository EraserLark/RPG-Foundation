extends Cutscene_State
class_name BattleIntro

func _init(sStack, cm, bm):
	super(sStack, cm, bm)
	
	#eventQueue.queueEmpty.connect(exit)

func enter(msg := {}):
	var fadeIn = AnimationEvent.new(eventQueue, cutsceneManager, "FadeIn")
	eventQueue.addEvent(fadeIn)
	
	var introMessage = TB_Event.new(eventQueue, StateStack, battleManager.battleUI.textbox, "Snowbros are ready to tussle!")
	eventQueue.addEvent(introMessage)
	
	eventQueue.popQueue()

func exit():
	super()
