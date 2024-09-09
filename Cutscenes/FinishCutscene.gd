extends GameState_Cutscene
class_name FinishCutscene

func _init(cm, sm):
	super(cm, sm)

func stackEnter(_msg := {}):
	super()
	
	##Access phantom cam to switch to
	cutsceneManager.stageManager.overworldWorld.currentRoom.cameraMarks.get_child(1).priority = 2
	
	var finishAnim = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FinishAnimation")
	cutsceneEQ.addEvent(finishAnim)
	
	var fadeOut = AnimationEvent.new(cutsceneEQ, cutsceneManager, "FadeIn")
	cutsceneEQ.addEvent(fadeOut)
	
	cutsceneEQ.popQueue()

func stackExit():
	super()
