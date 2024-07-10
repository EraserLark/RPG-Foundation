extends AnimationPlayer
class_name CutsceneManager

var battleManager
var battleUI
var battleStage

var currentCutscene : Cutscene_State

func _on_animation_finished(anim_name):
	currentCutscene.animFin()
