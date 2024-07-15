extends Control

@onready var textbox:= $Textbox

signal finishStartPhase

func _ready():
	textbox.boxFin.connect(textboxFinished)

func textboxFinished():
	emit_signal("finishStartPhase")
