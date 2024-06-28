extends Node

@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player
@onready var enemy := $BattleStage/Enemy
@onready var eventQueue := $EventQueue
@onready var stateMachine := $StateMachine

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	#battleUI.advanceBattleState.connect(advanceBattleState)
	stateMachine.get_node("Start").endBattle.connect(endBattle)
	stateMachine.get_node("Start").moveToPromptPhase.connect(advanceBattleState)
	battleUI.get_node("BattleMenu").moveToActionPhase.connect(advanceBattleState)
	#battleUI.textbox.typeText("Battle Start!")
	StateMachineStack.addSM(stateMachine)

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
			pass

func endBattle():
	self.queue_free()
