extends Node2D

@onready var animPlayer:= $AnimationPlayer

func interactAction(interacter : OW_Player):
	animPlayer.play("Saved")
