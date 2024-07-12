extends Cutscene_State
class_name BattleOutro

func _init(sStack, cm, bm):
	super(sStack, cm, bm)
	
	#cutsceneEQ.queueEmpty.connect(exit)

func enter(_msg := {}):
	var fadeOut = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FadeOut")
	cutsceneEQ.addEvent(fadeOut)
	
	cutsceneEQ.popQueue()

func exit():
	super()
