extends Resource
class_name NPC_Info

@export var npcName: String

@export var characterPortraits: Array[Texture]
@export var font: Font
@export var typeAudio: AudioStream

@export var spriteSheet: Texture
@export var hFrames: int
@export var vFrames: int

@export var collisionShape: Shape2D
