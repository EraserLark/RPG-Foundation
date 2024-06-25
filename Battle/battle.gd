extends Node

@onready var battleUI := $BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player

enum BattleState {START, PROMPT, ACTION, FINISH}
var currentState = BattleState.START

func _ready():
	battleUI.advanceBattleState.connect(advanceBattleState)
	battleUI.textbox.typeText("Battle Start!")

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
