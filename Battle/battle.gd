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

#func advanceBattleState():
	#match currentState:
		#BattleState.START:
			#stateMachine.transition_to("Prompt")
			#currentState = BattleState.PROMPT
			#print("Moving to: PROMPT")
		#BattleState.PROMPT:
			#stateMachine.transition_to("Action")
			#currentState = BattleState.ACTION
			#print("Moving to: ACTION")
		#BattleState.ACTION:
			#stateMachine.transition_to("Prompt")
			#currentState = BattleState.PROMPT
			#print("Moving to: PROMPT")
		#BattleState.FINISH:
			#stateMachine.transition_to("Finish")
			#currentState = BattleState.FINISH
			#print("Moving to: FINISH")
#
#func endBattle():	
	#currentState = BattleState.FINISH
	#advanceBattleState()
