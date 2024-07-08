extends Entity
class_name EnemyEntity

@export var enemyInfo : Resource
var enemyActor : Node2D
var localEnemy : EntityInfo

signal reactionComplete

func initialize(bm : BattleManager):
	super(bm)
	
	if(enemyInfo == null):
		enemyInfo = EntityInfo.new()
		enemyInfo.entityName = "Snowbro"
		enemyInfo.hp = 5
		enemyInfo.atk = 2
		
		var enemyAtk = enemyInfo.atk
		var enemyAction1 = Attack.new(null, "Punch", self, null, enemyAtk, 0)
		var enemyAction2 = Attack.new(null, "Bingo", self, null, enemyAtk + 2, 0)
		
		enemyInfo.actionList.append_array([enemyAction1, enemyAction2])
	
	localEnemy = enemyInfo
	
	enemyActor = bm.enemyActor

func chooseAttack():
	var chosenAction = localEnemy.actionList.pick_random()
	return chosenAction

func attack():
	enemyActor.attackFeedback()

func takeDamage(dmg : int):
	var trueDmg = localEnemy.calcDamage(dmg)
	localEnemy.takeDamage(dmg)
	
	enemyActor.damageFeedback(dmg)
	
	var remainingHealth = localEnemy.hp
	if(remainingHealth <= 0):
		enemyDead()

func gainStatus(statusName : String):
	if(statusName == "Poison"):
		battleManager.createStatus(PoisonStatus, self)
	emit_signal("reactionComplete")

func enemyDead():
	battleManager.battleState.eventQueue.currentEvent.battleOver()

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "SnowbroDamaged"):
		emit_signal("reactionComplete")
