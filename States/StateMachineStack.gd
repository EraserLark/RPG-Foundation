extends Node

var stateMachineStack : Array[StateMachine]
var currentStateMachine : StateMachine = null

@onready var textboxSM := "CanvasLayer/OW_UI/DialogueBox/StateMachine"
@onready var playerSM := "World/CastList/OW_Player/StateMachine"

func _ready():
	stateMachineStack = 
