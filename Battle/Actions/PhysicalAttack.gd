extends Action
class_name PhysicalAttack

@export var baseDamage : int = 1

func runAction():
	super()
	#target.takeDamage()
