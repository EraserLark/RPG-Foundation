extends Area2D

var owManager: OverworldManager

func _on_body_entered(body):
	if body is OW_Player:
		FinishCutscene.new(owManager.cutsceneManager, owManager)
