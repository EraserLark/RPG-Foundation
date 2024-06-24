extends Node

@onready var battleUI := $BattleUI
@onready var battleStage := $BattleStage
@onready var player := $BA_Player

func _ready():
	battleUI.textbox.typeText("Battle Start!")

func _process(delta):
	pass
