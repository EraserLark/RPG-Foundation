extends Node

@export var playerInfo : Resource

var eventManager
@onready var enemy = $"../BattleStage/BA_Enemy"
@onready var statsUI = $"../CanvasLayer/BattleUI/BattleMenu/Stats"
@onready var attackMenu = $"../CanvasLayer/BattleUI/BattleMenu/AttackMenu"
@onready var animPlayer = $"AnimationPlayer"

signal reactionComplete
signal playerDied

func _ready():
	playerInfo.owner = self
	
	eventManager = EventQueue.new()
	
	attackMenu.attackSelected.connect(attackChosen)
	playerInfo.healthRemaining.connect(takenDamage)
	playerInfo.damageTaken.connect(damageFeedback)
	
	var attack1 = Attack.new(eventManager, "Basic Attack", playerInfo, enemy.enemyInfo, 1, 0)
	var attack2 = Attack.new(eventManager, "Fireball", playerInfo, enemy.enemyInfo, 3, 0)
	var attack3 = Attack.new(eventManager, "Uppercut", playerInfo, enemy.enemyInfo, 2, 0)
	
	playerInfo.actionList.append(attack1)
	playerInfo.actionList.append(attack2)
	playerInfo.actionList.append(attack3)
	
	attackMenu.initMenu(playerInfo.actionList)

func attackChosen(attackNum : int):
	eventManager.addEvent(playerInfo.actionList[attackNum])

func damageFeedback(dmgAmt : int):
	animPlayer.play("PlayerDamaged")
	#var damageNumber := damageNum.instantiate()
	#damageNumber.setLabel(dmgAmt)
	#add_child(damageNumber)
	#print(str("Took ", dmgAmt, " damage!"))

func takenDamage(remainingHealth : int):
	statsUI.get_node("ProgressBar").value = remainingHealth
	statsUI.get_node("RichTextLabel").text = str(remainingHealth, " /10")
	
	if(remainingHealth <= 0):
		playerDead()

func playerDead():
	print("You Lose :(")
	emit_signal("playerDied")

func _on_animation_player_animation_finished(anim_name):
	emit_signal("reactionComplete")
