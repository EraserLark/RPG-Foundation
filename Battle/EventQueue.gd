extends Node
class_name EventQueue

@onready var battleManager = $".."
@onready var battleUI = $"../CanvasLayer/BattleUI"
@onready var player = $"../BA_Player"
@onready var enemy = $"../BattleStage/BA_Enemy"

var queue : Array[Action]

signal eventFinished

func _ready():
	var playerAction = Attack.new(self, "Player Attack", player.playerInfo, enemy.enemyInfo, 1, 0)
	var enemyAction = Attack.new(self, "Enemy Attack", enemy.enemyInfo, player.playerInfo, 2, 0)
	var resultsMessage : String = str("Player health: ", player.playerInfo.hp, "\nEnemy health: ", enemy.enemyInfo.hp)
	var results = TB_Action.new(self, battleUI, resultsMessage)
	
	queue.append(playerAction)
	queue.append(enemyAction)
	queue.append(results)

func popQueue():
	if(!queue.is_empty()):
		var nextAction : Action = queue.pop_front()
		nextAction.runAction()
	elif(battleManager.currentState == battleManager.BattleState.ACTION):
		battleManager.advanceBattleState()
