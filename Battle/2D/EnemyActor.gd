extends Node2D

@onready var sprite := $Sprite2D
@onready var animPlayer := $AnimationPlayer

var damageNum := preload("res://Battle/2D/PopUpNumber.tscn")

signal entered
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

func enterBattle():
	animPlayer.play("EnterBattle")

func setVisible(case : bool):
	self.setVisible(case)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "EnterBattle"):
		emit_signal("entered")
