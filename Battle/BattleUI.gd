extends Control

@onready var textbox := $Textbox
@onready var startState := $"../StateMachine/Start"

signal advanceBattleState

func _ready():
	startState.send_message.connect(textboxNewMessage)
	textbox.boxFin.connect(textboxFinished)

func textboxNewMessage(message):
	textbox.line = message
	StateMachineStack.addSM($Textbox/StateMachine)

func textboxFinished():
	emit_signal("advanceBattleState")
