extends AnimationPlayer
class_name CutsceneManager

var battleManager
var battleUI
var battleStage

var currentCutscene	#Cutscene_State or GameState_Cutscene

func _on_animation_finished(_anim_name):
	currentCutscene.animFin()
