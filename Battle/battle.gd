extends Node

@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player
@onready var enemy := $BattleStage/BA_Enemy
@onready var eventQueue := $EventQueue
@onready var stateMachine := $StateMachine

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	stateMachine.get_node("Start").endBattle.connect(endBattle)
	stateMachine.get_node("Start").moveToPromptPhase.connect(advanceBattleState)
	battleUI.get_node("BattleMenu").moveToActionPhase.connect(advanceBattleState)
	StateStack.addState(stateMachine)

func advanceBattleState():
	match currentState:
		BattleState.START:
			stateMachine.transition_to("Prompt")
			currentState = BattleState.PROMPT
			print("Moving to: PROMPT")
		BattleState.PROMPT:
			stateMachine.transition_to("Action")
			currentState = BattleState.ACTION
			print("Moving to: ACTION")
		BattleState.ACTION:
			stateMachine.transition_to("Prompt")
			currentState = BattleState.PROMPT
			print("Moving to: PROMPT")
		BattleState.FINISH:
			stateMachine.transition_to("Finish")
			currentState = BattleState.FINISH
			print("Moving to: FINISH")

func endBattle():	
	currentState = BattleState.FINISH
	advanceBattleState()
