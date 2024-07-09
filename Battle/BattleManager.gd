extends Node
class_name BattleManager

#BattleManager
@onready var battleRoster := $BattleRoster
@onready var playerEntity := $BattleRoster/PlayerEntity
@onready var enemyEntities := $BattleRoster/Enemies
var statusRoster : Array[StatusEffect]
var turnCount := 0

#Systems
var battleState : Battle_State
@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage

#Player
@onready var playerActor := $BattleStage/PlayerActor
@onready var playerUI := $CanvasLayer/BattleUI/PlayerUI

#Enemy
@onready var enemyActor := $BattleStage/EnemyActor

#Other
@onready var camera := $BattleStage/Camera2D

func _ready():
	playerUI.battleManager = self
	
	playerEntity.initialize(self)
	
	for enemy in battleRoster.enemies:
		enemy.initialize(self)
	
	camera.make_current()
	
	battleState = Battle_State.new(StateStack, self)
	StateStack.addState(battleState)

func updateTurnCount():
	turnCount += 1
	for status in statusRoster:
		status.currentCount += 1

func createStatus(statusEffect, target):
	var newStatus = statusEffect.new(self, target, statusRoster)
	statusRoster.append(newStatus)
	
	#if(battleState.currentPhase == battleState.battlePhases.ACTION):
	battleState.eventQueue.currentEvent.unresolvedStatuses.append(newStatus)
	print("Stall")
