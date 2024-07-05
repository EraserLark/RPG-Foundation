extends Action
class_name Attack

@export var baseDamage : int = 1
@export var specialCost : int = 0
#@export var effect : StatusEffect = null
#Associate minigame

func _init(eManager, attackName:String, sender:Entity, target:Entity, dmg:int, cost:int):
	super(eManager, sender, target)
	eventName = attackName
	self.sender = sender
	self.target = target
	baseDamage = dmg
	specialCost = cost

func runEvent():
	super()
	target.takeDamage(baseDamage)

#once all actions in the runAction() func are finished running, then finishAction()
func finishAttack():
	finishEvent()

class FireAttack:
	extends Attack

class Uppercut:
	extends Attack
