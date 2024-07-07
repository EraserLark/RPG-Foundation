extends Node
class_name BattleManager

#BattleManager
@onready var battleRoster := $BattleRoster
@onready var playerEntity := $BattleRoster/PlayerEntity
@onready var enemyEntity := $BattleRoster/EnemyEntity

#Systems
var battleState
@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage

#Player
@onready var playerActor := $BattleStage/PlayerActor
@onready var playerUI := $CanvasLayer/BattleUI/PlayerUI

#Enemy
@onready var enemyActor := $BattleStage/EnemyActor

#Other
@onready var camera := $BattleStage/Camera2D
var loser : Entity
var victor : Entity

func _ready():
	playerEntity.initialize(self)
	enemyEntity.initialize(self)
	
	camera.make_current()
	
	battleState = Battle_State.new(StateStack, self)
	StateStack.addState(battleState)
