extends Entity
class_name BattleEntity

var entityActor: BattleActor
var entityUI: EntityUI

##Outside references
var battleManager: BattleManager
var actor: BattleActor

##Inside references
var statusEffects: Array[StatusEffect]
#var localInfo: EntityInfo

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	if(bm == null):
		printerr("battleManager not passed")
		return
	battleManager = bm

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
	super(amt)

func decreaseDefense(amt: int):
	super(amt)

func revertStatus():
	super()

func gainHealth(amt: int):
	entityInfo.addHealth(amt)
	
	var remainingHealth = entityInfo.hp
	
	emit_signal("reactionComplete")

func takeDamage(dmg: int, pierce: bool):
	var trueDmg = dmg
	
	if(!pierce):
		trueDmg = entityInfo.calcDamage(dmg)
	
	entityInfo.takeDamage(trueDmg)
	actor.damageFeedback(trueDmg)
	
	var remainingHealth = entityInfo.hp
	#updateUI(remainingHealth)
	
	if(remainingHealth <= 0):
		var deathEvent = Death_Event.new(battleManager.actionPhase.actionEQ, self, battleManager)
		battleManager.actionPhase.actionEQ.queue.push_front(deathEvent)

func checkRoster():
	pass

func entityDead():
	#battleManager.battleRoster.enemies.erase(self)
	battleManager.actionPhase.actionEQ.queue.erase(entityInfo.selectedAction)
	actor.queue_free()
	for effect in statusEffects:
		effect.endStatus()
	#battleManager.battleRoster.checkEnemiesAlive()
	emit_signal("reactionComplete")
	queue_free()
