@tool
extends CharacterBody2D
class_name OW_Actor

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

@onready var ui:= $"../../../../CanvasLayer/OW_UI"
@onready var speechSpot:= $SpeechSpot

@export var npcResource: NPC_Info: set = setNPCInfo
@export var cutsceneResource: PackedScene

func setNPCInfo(info: NPC_Info):
	npcResource = info
	info.ow_npc = self
	
	self.name = info.npcName
	
	$Sprite2D.texture = info.spriteSheet
	$Sprite2D.offset = info.spriteOffset
	$Sprite2D.scale = info.spriteScale
	$Sprite2D.hframes = info.hFrames
	$Sprite2D.vframes = info.vFrames
	$Sprite2D.frame = info.currentFrame
	
	$Area2D/CollisionShape2D.shape = info.interactAreaShape
	$Area2D/CollisionShape2D.position = info.interactAreaOffset
	$CollisionShape2D.shape = info.collisionShape
	$CollisionShape2D.position = info.collisionOffset
	$SpeechSpot.position = info.speechSpotPos

func interactAction(interacter : OW_Player):
	#speak(message)
	if(cutsceneResource):
		runNPCTimeline(interacter.getPlayerNum())

func runNPCTimeline(playerNum: int):
	DialogueSystem.startTimeline(cutsceneResource, playerNum)

func createDBC():
	#Create dialogueBubbleContainer
	var dbc = load(dbcPath)
	var inst = dbc.instantiate()
	ui.add_child(inst)
	#Assign its transform to the SpeechSpot
	inst.refSpot = speechSpot
	return inst

func walkTo(pos: Vector2):
	pass

func faceDir(dir: Vector2):
	pass
