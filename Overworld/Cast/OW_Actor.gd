extends CharacterBody2D
class_name OW_Actor

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

@onready var ui:= $"../../../../CanvasLayer/OW_UI"
@onready var speechSpot:= $SpeechSpot

@export_multiline var message: Array[String]

func interactAction(interacter : OW_Player):
	speak(message)

func speak(message : Array[String]):
	#Create dialogueBubbleContainer
	var dbc = load(dbcPath)
	var inst = dbc.instantiate()
	ui.add_child(inst)
	#Assign its transform to the SpeechSpot
	inst.refSpot = speechSpot
	#Create a Dialoguebox state. Pass in the dbc as the parent
	var dbState = DialogueBox_State.new(StateStack, message, self.name, inst)
	StateStack.addState(dbState)