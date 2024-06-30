extends Entity
class_name PlayerEntity

@export var exp : int
@export var money : int
@export var items : Array[String]

func _ready():
	pass

func takeDamage(dmg : int):
	super(dmg)
	emit_signal("healthRemaining", hp)
