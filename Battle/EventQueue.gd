extends Node
class_name EventQueue

@onready var battleManager = $".."
@onready var battleUI = $"../CanvasLayer/BattleUI"
@onready var player = $"../BA_Player"
@onready var enemy = $"../BattleStage/BA_Enemy"

var queue : Array[Action]
var currentAction : Action

signal eventFinished

func _ready():
	enemy.reactionComplete.connect(finishAction)
	player.reactionComplete.connect(finishAction)

func finishAction():
	currentAction.finishAttack()

func popQueue():
	if(!queue.is_empty()):
		currentAction = queue.pop_front()
		currentAction.runAction()
	elif(battleManager.currentState == battleManager.BattleState.ACTION):
		battleManager.advanceBattleState()
