extends Resource
class_name EntityInfo

@export var entityName : String
@export var hp : int
@export var atk : int
@export var def : int
@export var sprite : Texture

var owner
var actionList : Array[Action]
var selectedAction : Action
var animPlayer : AnimationPlayer
var audioPlayer : AudioStreamPlayer2D

var animFinished : bool = false
var audioFinished : bool = false

signal damageTaken(dmg)
signal healthRemaining(health)

func calcDamage(dmg : int):
	var trueDmg := dmg-def
	if(trueDmg < 0):
		trueDmg = 0
	
	return trueDmg

func takeDamage(dmg : int):
	hp -= dmg
	if(hp < 0):
		hp = 0
