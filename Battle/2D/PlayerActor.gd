extends Node2D

var battleManager
var player

@onready var cam = $"../Camera2D"
@onready var animPlayer = $AnimationPlayer

var damageNum := preload("res://Battle/2D/PopUpNumber.tscn")

func damageFeedback(dmgAmt : int):
	animPlayer.play("PlayerDamaged")
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
