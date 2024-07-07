extends Entity
class_name EnemyEntity

@export var enemyInfo : Resource
var enemyActor : Node2D
var localEnemy : EntityInfo

signal reactionComplete

func initialize(bm : BattleManager):
	super(bm)
	enemyActor = bm.enemyActor
	
	localEnemy = enemyInfo

func attack():
	enemyActor.attackFeedback()

func takeDamage(dmg : int):
	var trueDmg = localEnemy.calcDamage(dmg)
	localEnemy.takeDamage(dmg)
	
	enemyActor.damageFeedback(dmg)
	
	var remainingHealth = localEnemy.hp
	if(remainingHealth <= 0):
		enemyDead()

func enemyDead():
	battleManager.battleState.eventQueue.currentEvent.battleOver()

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "SnowbroDamaged"):
		emit_signal("reactionComplete")
