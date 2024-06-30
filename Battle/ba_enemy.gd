extends Node2D

@export var enemyInfo : Resource

@onready var animPlayer := $AnimationPlayer

var damageNum := preload("res://Battle/PopUpNumber.tscn")

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
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
	#print(str("Took ", dmgAmt, " damage!"))
