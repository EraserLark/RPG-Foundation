extends  GameState_Cutscene
class_name BattleOutro

func _init(cm, bm):
	super(cm, bm)

func stackEnter(_msg := {}):
	super()
	
	var fadeOut = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FadeOut")
	cutsceneEQ.addEvent(fadeOut)
	
	cutsceneEQ.popQueue()

func stackExit():
	super()
