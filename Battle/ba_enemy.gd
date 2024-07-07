extends Node2D

@onready var animPlayer := $AnimationPlayer

var damageNum := preload("res://Battle/PopUpNumber.tscn")

signal reactionComplete
signal enemyDied

func _ready():
	pass
	#enemyInfo.owner = self
	#enemyInfo.animPlayer = self.animPlayer
	#enemyInfo.audioPlayer = get_node("AudioStreamPlayer2D")

func damageFeedback(dmgAmt : int):
	animPlayer.play("SnowbroDamaged")
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
