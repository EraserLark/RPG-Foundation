extends Action
class_name Attack

@export var baseDamage : int = 1
@export var specialCost : int = 0
#@export var effect : StatusEffect = null
#Associate minigame

func runAction():
	super()
	target.takeDamage(baseDamage)
