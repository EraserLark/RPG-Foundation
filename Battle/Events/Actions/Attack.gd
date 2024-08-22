extends Action
class_name Attack

@export var baseDamage:= 1
var bonusDamage:= 0
@export var specialCost:= 0

func _init(eManager, stageManager: StageManager, attackName:String, send:Entity, targ:Entity, targType, dmg:int, cost:int, mg:String):
	super(eManager, send, targ, targType, stageManager)
	eventName = attackName
	self.sender = send
	self.target = targ
	baseDamage = dmg
	specialCost = cost
	
	if mg != "":
		actionMinigame = load(mg)

func runEvent():
	super()
	target.reactionComplete.connect(finishAttack)
	sender.attack()
	var trueDamage = baseDamage + bonusDamage
	target.takeDamage(trueDamage, false)

#once all actions in the runEvent() func are finished running, then finishAction()
func finishAttack():
	target.reactionComplete.disconnect(finishAttack)
	finishEvent()

class FireAttack:
	extends Attack

class Uppercut:
	extends Attack
