extends Action
class_name PhysicalAttack

@export var baseDamage : int = 2

func runAction():
	super()
	target.takeDamage(baseDamage)
