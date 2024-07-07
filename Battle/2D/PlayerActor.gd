extends Node2D

var battleManager
var player

@onready var cam = $"../Camera2D"
@onready var animPlayer = $AnimationPlayer

func damageAnimation():
	animPlayer.play("PlayerDamaged")
