extends Node2D

@export var enemyInfo : Resource

@onready var animPlayer := $AnimationPlayer

func _ready():
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
	print(str("Took ", dmgAmt, " damage!"))
