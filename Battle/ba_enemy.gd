extends Node2D

@export var enemyInfo : Resource

@onready var animPlayer := $AnimationPlayer

var damageNum := preload("res://Battle/PopUpNumber.tscn")

signal reactionComplete
signal enemyDied

func _ready():
	enemyInfo.animPlayer = self.animPlayer
	enemyInfo.audioPlayer = get_node("AudioStreamPlayer2D")
	
	enemyInfo.damageTaken.connect(damageFeedback)
	#entityName = enemyInfo.entName
	#sprite = enemyInfo.sprite
	#hp = enemyInfo.hp
	#atk = enemyInfo.atk
	#def = enemyInfo.def
	#actionList = enemyInfo.actionList
	#Set area2D size and collision shape if necessary
	#AudioStreamPlayer2D.stream = enemyInfo.audio

func damageFeedback(dmgAmt : int):
	animPlayer.play("TakeDamage")
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
	#print(str("Took ", dmgAmt, " damage!"))
	if(dmgAmt >= enemyInfo.hp + dmgAmt):
		enemyDead()

func enemyDead():
	print("You Win! :D")
	emit_signal("enemyDied")

func _on_animation_player_animation_finished(anim_name):
	enemyInfo.animFinished = true
	enemyInfo.audioFinished = true
	
	if(enemyInfo.animFinished && enemyInfo.audioFinished):
		enemyInfo.animFinished = false
		enemyInfo.audioFinished = false
		
		emit_signal("reactionComplete")
