extends Cutscene_State
class_name BattleOutro

func _init(sStack, cm, bm):
	super(sStack, cm, bm)
	
	#eventQueue.queueEmpty.connect(exit)

func enter(msg := {}):
	var fadeOut = AnimationEvent.new(eventQueue, cutsceneManager, "FadeOut")
	eventQueue.addEvent(fadeOut)
	
	eventQueue.popQueue()

func exit():
	super()
