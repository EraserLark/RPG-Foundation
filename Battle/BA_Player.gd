extends Node

@export var playerInfo : Resource

@onready var eventManager = $"../EventQueue"
@onready var enemy = $"../BattleStage/BA_Enemy"
@onready var attackMenu = $"../CanvasLayer/BattleUI/BattleMenu/AttackMenu"

func _ready():
	var attack1 = Attack.new(eventManager, "Basic Attack", playerInfo, enemy.enemyInfo, 1, 0)
	var attack2 = Attack.new(eventManager, "Fireball", playerInfo, enemy.enemyInfo, 3, 0)
	var attack3 = Attack.new(eventManager, "Uppercut", playerInfo, enemy.enemyInfo, 2, 0)
	
	playerInfo.actionList[attack1.actionName] = attack1
	playerInfo.actionList[attack2.actionName] = attack2
	playerInfo.actionList[attack3.actionName] = attack3
	
	attackMenu.initMenu(playerInfo.actionList)
