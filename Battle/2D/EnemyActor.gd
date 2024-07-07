extends Node2D

@onready var animPlayer := $AnimationPlayer

var damageNum := preload("res://Battle/2D/PopUpNumber.tscn")

signal reactionComplete
signal enemyDied

func _ready():
	pass

func damageFeedback(dmgAmt : int):
	animPlayer.play("SnowbroDamaged")
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)

func attackFeedback():
	animPlayer.play("AttackPlayer")
