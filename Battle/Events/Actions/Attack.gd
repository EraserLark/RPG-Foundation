extends Action
class_name Attack

@export var baseDamage : int = 1
@export var specialCost : int = 0
#@export var effect : StatusEffect = null
#Associate minigame

func _init(eManager, battleManager, attackName:String, send:Entity, targ:Entity, targType, dmg:int, cost:int):
	super(eManager, send, targ, targType, battleManager)
	eventName = attackName
	self.sender = send
	self.target = targ
	baseDamage = dmg
	specialCost = cost

func runEvent():
	super()
	target.reactionComplete.connect(finishAttack)
	sender.attack()
	target.takeDamage(baseDamage, false)

#once all actions in the runEvent() func are finished running, then finishAction()
func finishAttack():
	target.reactionComplete.disconnect(finishAttack)
	finishEvent()

class FireAttack:
	extends Attack

class Uppercut:
	extends Attack
