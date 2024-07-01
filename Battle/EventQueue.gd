extends Node
class_name EventQueue

@onready var battleManager = $".."
@onready var battleUI = $"../CanvasLayer/BattleUI"
@onready var player = $"../BA_Player"
@onready var enemy = $"../BattleStage/BA_Enemy"

var queue : Array[Action]
var currentAction : Action
var exit := false

signal eventFinished

func _ready():
	enemy.reactionComplete.connect(finishAction)
	player.reactionComplete.connect(finishAction)
	player.playerDied.connect(emergencyExit)
	enemy.enemyDied.connect(emergencyExit)

func finishAction():
	currentAction.finishAttack()

func emergencyExit():
	exit = true

func popQueue():
	if(exit):
		battleManager.currentState = battleManager.BattleState.FINISH
		battleManager.advanceBattleState()
	elif(!queue.is_empty()):
		currentAction = queue.pop_front()
		currentAction.runAction()
	elif(battleManager.currentState == battleManager.BattleState.ACTION):
		battleManager.advanceBattleState()
