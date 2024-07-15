extends Entity
class_name EnemyEntity

var enemyActorScene = preload("res://Battle/2D/EnemyActor.tscn")

#@export var localInfo : Resource
var enemyActor : Node2D
#var localEnemy : EntityInfo

func initialize(bm : BattleManager):
	super(bm)
	
	var enemyAtk = localInfo.atk
	var enemyAction1 = Attack.new(null, bm, "Punch", self, null, Action.TargetTypes.PLAYER, enemyAtk, 0)
	var enemyAction2 = Attack.new(null, bm, "Bingo", self, null, Action.TargetTypes.PLAYER, enemyAtk + 2, 0)
	
	enemyAction1.targetType = Action.TargetTypes.PLAYER
	enemyAction2.targetType = Action.TargetTypes.PLAYER
	
	localInfo.actionList.append_array([enemyAction1, enemyAction2])
	
	if(enemyActor == null):
		enemyActor = enemyActorScene.instantiate()
		actor = enemyActor
		battleManager.battleStage.enemies.add_child(enemyActor)
		enemyActor.position = Vector2(randi_range(100,1000), randi_range(200,300))
		enemyActor.animPlayer.animation_finished.connect(_on_animation_player_animation_finished)
		enemyActor.sprite.visible = false

func chooseAttack():
	var chosenAction = localInfo.actionList.pick_random()
	localInfo.selectedAction = chosenAction
	return chosenAction

func attack():
	enemyActor.attackFeedback()

#func takeDamage(dmg : int):
	#var trueDmg = localEnemy.calcDamage(dmg)
	#localEnemy.takeDamage(trueDmg)
	#
	#enemyActor.damageFeedback(trueDmg)
	#
	#var remainingHealth = localEnemy.hp
	#if(remainingHealth <= 0):
		#enemyDead()

#func gainStatus(statusType):
	#if(statusType == Status.Type.POISON):
		#applyStatus(PoisonStatus, battleManager.statusRoster)
	#emit_signal("reactionComplete")

func entityDead():
	battleManager.battleRoster.enemies.erase(self)
	battleManager.battleRoster.checkEnemiesAlive()
	super()

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "SnowbroDamaged"):
		emit_signal("reactionComplete")
