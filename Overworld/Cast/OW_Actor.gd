@tool
extends CharacterBody2D
class_name OW_Actor

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

#@onready var ui:= $"../../../../CanvasLayer/OW_UI" - Uncomment
@onready var speechSpot:= $SpeechSpot

@export var npcResource: NPC_Info: set = setNPCInfo
@export var cutsceneResource: PackedScene

func setNPCInfo(info: NPC_Info):
	npcResource = info
	info.ow_npc = self
	
	self.name = info.npcName
	$Sprite2D.texture = info.spriteSheet
	$Sprite2D.offset = info.spriteOffset
	$Sprite2D.hframes = info.hFrames
	$Sprite2D.vframes = info.vFrames
	$Sprite2D.frame = info.currentFrame
	$CollisionShape2D.shape = info.collisionShape
	$SpeechSpot.position = info.speechSpotPos

func interactAction(interacter : OW_Player):
	#speak(message)
	runNPCTimeline(interacter.getPlayerNum())

func runNPCTimeline(playerNum: int):
	DialogueSystem.startTimeline(cutsceneResource, playerNum)

func createDBC():
	#Create dialogueBubbleContainer
	var dbc = load(dbcPath)
	var inst = dbc.instantiate()
	#ui.add_child(inst) -- Uncomment
	#Assign its transform to the SpeechSpot
	inst.refSpot = speechSpot
	return inst

func walkTo(pos: Vector2):
	pass

func faceDir(dir: Vector2):
	pass

#func speak(message : Array[String]):
	#var bubbleSpot = createDBC()
	#Create a Dialoguebox state. Pass in the dbc as the parent
	#var dbState = DialogueBox_State.new(StateStack, message, self.name, inst)
	#StateStack.addState(dbState)
