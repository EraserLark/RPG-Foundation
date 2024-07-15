extends Node
class_name Entity

var battleManager : BattleManager
var actor
var statusEffects : Array[StatusEffect]
@export var entityInfo : Resource
var localInfo

signal reactionComplete

func initialize(bm : BattleManager):
	battleManager = bm
	localInfo = entityInfo.duplicate()

func getClassInstance():
	return self

func gainStatus(statusType):
	if(statusType == Status.Type.POISON):
		applyStatus(PoisonStatus, battleManager.statusRoster)
	elif(statusType == Status.Type.DEFUP):
		applyStatus(DefenseStatus, battleManager.statusRoster)
	emit_signal("reactionComplete")

func applyStatus(statusEffect, statusRoster):
	var newStatus = statusEffect.new(battleManager, self, statusRoster)
	statusEffects.append(newStatus)
	statusRoster.append(newStatus)
	
	battleManager.battleState.battleEQ.currentEvent.unresolvedStatuses.append(newStatus)

func boostDefense(amt : int):
	entityInfo.def += amt

func revertStatus():
	entityInfo.def -= 1

func gainHealth(amt : int):
	entityInfo.addHealth(amt)
	
	var remainingHealth = entityInfo.hp
	
	emit_signal("reactionComplete")

func takeDamage(dmg : int):
	var trueDmg = entityInfo.calcDamage(dmg)
	entityInfo.takeDamage(trueDmg)
	
	actor.damageFeedback(trueDmg)
	
	var remainingHealth = entityInfo.hp
	updateUI(remainingHealth)
	
	if(remainingHealth <= 0):
		entityDead()

func updateUI(hp : int):
	pass

func entityDead():
	#battleManager.battleRoster.enemies.erase(self)
	battleManager.battleState.battleEQ.currentEvent.actionEQ.queue.erase(entityInfo.selectedAction)
	actor.queue_free()
	for effect in statusEffects:
		effect.endStatus()
	#battleManager.battleRoster.checkEnemiesAlive()
	emit_signal("reactionComplete")
	queue_free()
