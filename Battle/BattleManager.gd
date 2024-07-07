extends Node
class_name BattleManager

#BattleManager
@onready var battleRoster := $BattleRoster
@onready var playerEntity := $BattleRoster/PlayerEntity
@onready var enemyEntity := $BattleRoster/EnemyEntity

#Systems
@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage

#Player
@onready var playerActor := $BattleStage/PlayerActor
@onready var playerUI := $CanvasLayer/BattleUI/PlayerUI

#Enemy
@onready var enemyActor := $BattleStage/EnemyActor

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	playerEntity.initialize(self)
	enemyEntity.initialize(self)
	
	var battleUI = $"CanvasLayer/BattleUI"
	var battleState = Battle_State.new(StateStack, self)
	StateStack.addState(battleState)
