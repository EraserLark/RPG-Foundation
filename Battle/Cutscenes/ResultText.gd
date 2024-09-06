extends  GameState_Cutscene
class_name ResultText

func _init(cm, bm):
	super(cm, bm)

func stackEnter(_msg := {}):
	super()
	
	if !stageManager.checkEnemiesAlive():
		var victoryText = AnimationEvent.new(cutsceneEQ, stageManager.cutsceneManager, "BattleMessage_Victory")
		cutsceneEQ.addEvent(victoryText)
	elif !stageManager.checkPlayersAlive():
		var defeatText = AnimationEvent.new(cutsceneEQ, stageManager.cutsceneManager, "BattleMessage_Defeat")
		cutsceneEQ.addEvent(defeatText)
	
	cutsceneEQ.popQueue()

func stackExit():
	super()
