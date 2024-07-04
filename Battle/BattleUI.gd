extends Control

@onready var textbox := $Textbox
@onready var startState := $"../../StateMachine/Start"

signal finishStartPhase

func _ready():
	startState.send_message.connect(textboxNewMessage)
	textbox.boxFin.connect(textboxFinished)

func textboxNewMessage(message):
	textbox.line = message
	StateStack.addState($Textbox/StateMachine)

func textboxFinished():
	emit_signal("finishStartPhase")
