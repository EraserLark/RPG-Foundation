@tool
extends Resource
class_name NPC_Info

var ow_npc: OW_Actor

@export var npcName: String: set = setName

@export_group("Interaction")
@export var characterFlags: FlagList
@export var timelines: Dictionary = {}

@export_group("Sprite Properties")
@export var spriteSheet: Texture: set = setSpriteTexture
@export var spriteOffset: Vector2: set = setSpriteOffset
@export var spriteScale: Vector2 = Vector2(1,1)
@export var hFrames: int = 1: set = setHFrames
@export var vFrames: int = 1: set = setVFrames
@export var currentFrame: int: set = setCurrentFrame

@export_group("UI Properties")
@export var characterPortraits: Array[Texture]
@export var font: Font
@export var typeAudio: AudioStream

@export_group("Other Properties")
@export var interactAreaShape: Shape2D
@export var interactAreaOffset: Vector2
@export var collisionShape: Shape2D: set = setCollisionShape
@export var collisionOffset: Vector2: set = setCollisionOffset
@export var speechSpotPos: Vector2: set = setSpeechSpot

func setName(name: String):
	npcName = name
	if(ow_npc):
		ow_npc.name = name

func setSpriteTexture(texture: Texture):
	spriteSheet = texture
	if(ow_npc):
		ow_npc.get_node("Sprite2D").texture = spriteSheet

func setSpriteOffset(offset: Vector2):
	spriteOffset = offset
	if(ow_npc):
		ow_npc.get_node("Sprite2D").offset = spriteOffset

func setSpriteScale(size: Vector2):
	spriteScale = size
	if(ow_npc):
		ow_npc.get_node("Sprite2D").scale = spriteScale

func setHFrames(hf: int):
	if(hf <= 0):
		hf = 1
	hFrames = hf
	if(ow_npc):
		ow_npc.get_node("Sprite2D").hframes = hFrames

func setVFrames(vf: int):
	if(vf <= 0):
		vf = 1
	vFrames = vf
	if(ow_npc):
		ow_npc.get_node("Sprite2D").vframes = vFrames

func setCurrentFrame(cf: int):
	currentFrame = cf
	if(ow_npc):
		ow_npc.get_node("Sprite2D").frame = currentFrame

func setInteractShape(shape: Shape2D):
	interactAreaShape = shape
	if(ow_npc):
		ow_npc.get_node("Area2D").get_child(0).shape = interactAreaShape

func setInteractOffset(offset: Vector2):
	interactAreaOffset = offset
	if(ow_npc):
		ow_npc.get_node("Area2D").get_child(0).position = interactAreaOffset

func setCollisionShape(shape: Shape2D):
	collisionShape = shape
	if(ow_npc):
		ow_npc.get_node("CollisionShape2D").shape = collisionShape

func setCollisionOffset(offset: Vector2):
	collisionOffset = offset
	if(ow_npc):
		ow_npc.get_node("CollisionShape2D").position = collisionOffset

func setSpeechSpot(pos: Vector2):
	speechSpotPos = pos
	if(ow_npc):
		ow_npc.get_node("SpeechSpot").position = speechSpotPos
