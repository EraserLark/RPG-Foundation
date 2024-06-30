extends Node

@export var playerInfo : Resource

@onready var eventManager = $"../EventQueue"
@onready var enemy = $"../BattleStage/BA_Enemy"
@onready var statsUI = $"../CanvasLayer/BattleUI/BattleMenu/Stats"
@onready var attackMenu = $"../CanvasLayer/BattleUI/BattleMenu/AttackMenu"

func _ready():
	attackMenu.attackSelected.connect(attackChosen)
	playerInfo.healthRemaining.connect(takenDamage)
	
	var attack1 = Attack.new(eventManager, "Basic Attack", playerInfo, enemy.enemyInfo, 1, 0)
	var attack2 = Attack.new(eventManager, "Fireball", playerInfo, enemy.enemyInfo, 3, 0)
	var attack3 = Attack.new(eventManager, "Uppercut", playerInfo, enemy.enemyInfo, 2, 0)
	
	playerInfo.actionList.append(attack1)
	playerInfo.actionList.append(attack2)
	playerInfo.actionList.append(attack3)
	
	attackMenu.initMenu(playerInfo.actionList)

func attackChosen(attackNum : int):
	eventManager.queue.append(playerInfo.actionList[attackNum])

func takenDamage(remainingHealth : int):
	statsUI.get_node("ProgressBar").value = remainingHealth
	statsUI.get_node("RichTextLabel").text = str(remainingHealth, " /10")
