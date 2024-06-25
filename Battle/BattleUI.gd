extends Control

@onready var textbox := $Textbox

signal advanceBattleState

func _ready():
	textbox.boxFin.connect(textboxFinished)

func textboxFinished():
	emit_signal("advanceBattleState")
