extends Node

@onready var battleUI := $CanvasLayer/BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player
@onready var enemy := $BattleStage/Enemy

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	battleUI.advanceBattleState.connect(advanceBattleState)
	$StateMachine/Start.endBattle.connect(endBattle)
	battleUI.get_node("Textbox").boxFin.connect(advanceBattleState)
	#battleUI.textbox.typeText("Battle Start!")
	StateMachineStack.addSM($StateMachine)

func _process(delta):
	match currentState:
		BattleState.START:
			pass
		BattleState.PROMPT:
			pass
		BattleState.ACTION:
			pass
		BattleState.FINISH:
			pass

func advanceBattleState():
	$StateMachine.transition_to("Prompt")

func endBattle():
	self.queue_free()
