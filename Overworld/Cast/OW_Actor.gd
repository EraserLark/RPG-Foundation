@tool
extends CharacterBody2D
class_name OW_Actor

var dbcPath = "res://UI/DialogueBubbleContainer.tscn"

##Children references
@onready var speechSpot:= $SpeechSpot
@onready var navigation_agent_2d:= $NavigationAgent2D
@onready var collider:= $CollisionShape2D
@onready var interactCollider:= $Area2D/CollisionShape2D

##Parent references
var worldUI: Control

##Export vars
@export var npcResource: NPC_Info: set = setNPCInfo
@export var cutsceneResource: PackedScene
var navTarget: Vector2#: set = setNavTarget
@export var pathToFollow: PathFollow2D
@export var walkSpeed: float = 10

signal walkFinished(path)

func _ready():
	print("Actor Ready Start")
	print("Actor Ready Finish")

func initialize(om: OverworldManager, rm: Room):
	worldUI = om.stageUI

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

func checkSpawnFlags():
	if npcResource.characterFlags != null:
		if(npcResource.characterFlags.flags.has("Disliked")):
			if(npcResource.characterFlags.flags["Disliked"]):
				var markers = DialogueSystem.cutsceneMarkers
				var mark = DialogueSystem.cutsceneMarkers.marksArray[0]
				position = mark.position
		elif(npcResource.characterFlags.flags.has("Problem Solved")):
			if(npcResource.characterFlags.flags["Problem Solved"]):
				var markers = DialogueSystem.cutsceneMarkers
				var mark = DialogueSystem.cutsceneMarkers.marksArray[0]
				position = mark.position

func interactAction(interacter : OW_Player):
	var timelinePath = getCorrectTimeline()
	if(timelinePath != ""):
		runNPCTimeline(timelinePath, interacter.getPlayerNum())

func getCorrectTimeline() -> String:
	var npcFlags = npcResource.characterFlags.flags
	var timelines = npcResource.timelines
	if(npcFlags["1st Interaction"]):
		return timelines["1st_Interaction"]
	elif(npcFlags["Player Has Solution"]):
		return timelines["PlayerSolution"]
	elif(npcFlags["Troubled"]):
		return timelines["Troubled"]
		
	elif(npcFlags["Liked"]):
		return timelines["LikedInteraction"]
	elif(npcFlags["Disliked"]):
		return timelines["DislikedInteraction"]
	else:
		printerr("No correct timeline available")
		return ""

func runNPCTimeline(tlPath: String, playerNum: int):
	interactCollider.disabled = true
	DialogueSystem.startTimeline(tlPath, playerNum)

func timelineFinished():
	interactCollider.disabled = false

func createDBC():
	#Create dialogueBubbleContainer
	var dbc = load(dbcPath)
	var inst = dbc.instantiate()
	worldUI.add_child(inst)
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
	if !navigation_agent_2d.is_navigation_finished():
		var currentPos = global_position
		var nextPathPos = navigation_agent_2d.get_next_path_position()
		
		var newVelocity = currentPos.direction_to(nextPathPos) * walkSpeed
		
		if navigation_agent_2d.avoidance_enabled:
			navigation_agent_2d.set_velocity(newVelocity)
		else:
			velocity = newVelocity
		move_and_slide()

func walkTo(pos: Vector2):
	pass

func faceDir(dir: Vector2):
	pass

func disableCollider(condition: bool):
	collider.disabled = condition

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity

func _on_navigation_agent_2d_target_reached():
	emit_signal("walkFinished", self)
