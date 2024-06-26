extends Node

@onready var battleUI := $BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	battleUI.advanceBattleState.connect(advanceBattleState)
	$StateMachine/Start.endBattle.connect(endBattle)
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
	currentState = BattleState.PROMPT

func endBattle():
	self.queue_free()
