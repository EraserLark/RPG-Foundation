@tool
extends CharacterBody2D
class_name OW_Actor

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

@onready var ui:= $"../../../../CanvasLayer/OW_UI"
@onready var speechSpot:= $SpeechSpot
@onready var navigation_agent_2d:= $NavigationAgent2D

@export var npcResource: NPC_Info: set = setNPCInfo
@export var cutsceneResource: PackedScene
var navTarget: Vector2#: set = setNavTarget
@export var walkSpeed: float = 10

signal walkFinished()

func _ready():
	#setNavTarget(Vector2(0,0))
	pass

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

func setNavTarget(target: Vector2):
	navTarget = target
	#await self.ready
	await get_tree().physics_frame
	if Engine.is_editor_hint():
		print("In Editor")
		return
	else:
		navigation_agent_2d.target_position = navTarget

func _physics_process(delta):
	if navigation_agent_2d.is_navigation_finished() or Engine.is_editor_hint():
		return
	
	var currentPos = global_position
	var nextPathPos = navigation_agent_2d.get_next_path_position()
	
	var newVelocity = currentPos.direction_to(nextPathPos) * walkSpeed
	#newVelocity *= walkSpeed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(newVelocity)
	else:
		velocity = newVelocity
	
	move_and_slide()

func walkTo(pos: Vector2):
	pass

func faceDir(dir: Vector2):
	pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity

func _on_navigation_agent_2d_target_reached():
	emit_signal("walkFinished")
