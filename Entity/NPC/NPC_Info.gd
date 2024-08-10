@tool
extends Resource
class_name NPC_Info

var ow_npc: OW_Actor

@export var npcName: String

@export_group("Sprite Properties")
@export var spriteSheet: Texture: set = setSpriteTexture
@export var spriteOffset: Vector2: set = setSpriteOffset
@export var hFrames: int: set = setHFrames
@export var vFrames: int: set = setVFrames
@export var currentFrame: int: set = setCurrentFrame

@export_group("UI Properties")
@export var characterPortraits: Array[Texture]
@export var font: Font
@export var typeAudio: AudioStream

@export_group("Other Properties")
@export var collisionShape: Shape2D: set = setCollisionShape
@export var speechSpotPos: Vector2: set = setSpeechSpot

func setSpriteTexture(texture: Texture):
	spriteSheet = texture
	if(ow_npc):
		ow_npc.get_node("Sprite2D").texture = spriteSheet

func setSpriteOffset(offset: Vector2):
	spriteOffset = offset
	if(ow_npc):
		ow_npc.get_node("Sprite2D").offset = spriteOffset

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

func setCollisionShape(shape: Shape2D):
	collisionShape = shape
	if(ow_npc):
		ow_npc.get_node("CollisionShape2D").shape = collisionShape

func setSpeechSpot(pos: Vector2):
	speechSpotPos = pos
	if(ow_npc):
		ow_npc.get_node("SpeechSpot").position = speechSpotPos
