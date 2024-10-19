extends Node2D
class_name Sign

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

@onready var speechSpot:= $SpeechSpot
var worldUI: Control

@export_multiline var lines : Array[String]

func _ready():
	pass

func interactAction(interacter: OW_Player):
	var playerEntity = interacter.playerEntity
	var dialogueBoxParent = createDBC()
	var tbState = DialogueBox_State.new(playerEntity.playerStateStack, lines, self.name, dialogueBoxParent)
	playerEntity.playerStateStack.addState(tbState)

func createDBC():
	#Create dialogueBubbleContainer
	var dbc = load(dbcPath)
	var inst = dbc.instantiate()
	worldUI.add_child(inst)
	#Assign its transform to the SpeechSpot
	inst.refSpot = speechSpot
	return inst
