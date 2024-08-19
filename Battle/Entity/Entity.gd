extends Node
class_name Entity

##Outside references
var battleManager: BattleManager
var actor
@export var entityInfo: Resource

##Inside references
var statusEffects: Array[StatusEffect]
var localInfo: EntityInfo

signal reactionComplete

func initialize(bm: BattleManager):
	battleManager = bm
	localInfo = entityInfo.duplicate_deep_workaround()
	print("Stall")

func getClassInstance():
	return self

func gainStatus(statusType):
	if(statusType == Status.Type.POISON):
		applyStatus(PoisonStatus, battleManager.actionPhase.statusRoster)
	elif(statusType == Status.Type.DEFUP):
		applyStatus(DefenseStatus, battleManager.actionPhase.statusRoster)
	emit_signal("reactionComplete")

func applyStatus(statusEffect, statusRoster):
	var newStatus = statusEffect.new(battleManager, self, statusRoster)
	statusEffects.append(newStatus)
	statusRoster.append(newStatus)
	
	battleManager.actionPhase.unresolvedStatuses.append(newStatus)

func boostDefense(amt: int):
	localInfo.def += amt

func decreaseDefense(amt: int):
	localInfo.def -= amt

func revertStatus():
	localInfo.def -= 1

func gainHealth(amt: int):
	localInfo.addHealth(amt)
	
	var remainingHealth = localInfo.hp
	
	emit_signal("reactionComplete")

func takeDamage(dmg: int, pierce: bool):
	var trueDmg = dmg
	
	if(!pierce):
		trueDmg = localInfo.calcDamage(dmg)
	
	localInfo.takeDamage(trueDmg)
	actor.damageFeedback(trueDmg)
	
	var remainingHealth = localInfo.hp
	#updateUI(remainingHealth)
	
	if(remainingHealth <= 0):
		var deathEvent = Death_Event.new(battleManager.actionPhase.actionEQ, self, battleManager)
		battleManager.actionPhase.actionEQ.queue.push_front(deathEvent)

func checkRoster():
	pass

func entityDead():
	#battleManager.battleRoster.enemies.erase(self)
	battleManager.actionPhase.actionEQ.queue.erase(localInfo.selectedAction)
	actor.queue_free()
	for effect in statusEffects:
		effect.endStatus()
	#battleManager.battleRoster.checkEnemiesAlive()
	emit_signal("reactionComplete")
	queue_free()
