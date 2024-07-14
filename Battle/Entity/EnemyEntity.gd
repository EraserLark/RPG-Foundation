extends Entity
class_name EnemyEntity

var enemyActorScene = preload("res://Battle/2D/EnemyActor.tscn")

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
		var enemyAction1 = Attack.new(null, "Punch", self, null, battleManager.battleRoster.players, enemyAtk, 0)
		var enemyAction2 = Attack.new(null, "Bingo", self, null, battleManager.battleRoster.players, enemyAtk + 2, 0)
		
		enemyInfo.actionList.append_array([enemyAction1, enemyAction2])
	
	localEnemy = enemyInfo
	
	if(enemyActor == null):
		enemyActor = enemyActorScene.instantiate()
		actor = enemyActor
		battleManager.battleStage.enemies.add_child(enemyActor)
		enemyActor.position = Vector2(randi_range(100,1000), randi_range(200,300))
		enemyActor.animPlayer.animation_finished.connect(_on_animation_player_animation_finished)
		enemyActor.sprite.visible = false

func chooseAttack():
	var chosenAction = localEnemy.actionList.pick_random()
	localEnemy.selectedAction = chosenAction
	return chosenAction

func attack():
	enemyActor.attackFeedback()

func takeDamage(dmg : int):
	var trueDmg = localEnemy.calcDamage(dmg)
	localEnemy.takeDamage(trueDmg)
	
	enemyActor.damageFeedback(trueDmg)
	
	var remainingHealth = localEnemy.hp
	if(remainingHealth <= 0):
		enemyDead()

func gainStatus(statusName : String):
	if(statusName == "Poison"):
		battleManager.createStatus(PoisonStatus, self)
	emit_signal("reactionComplete")

func enemyDead():
	battleManager.battleRoster.enemies.erase(self)
	battleManager.battleState.battleEQ.currentEvent.actionEQ.queue.erase(localEnemy.selectedAction)
	enemyActor.queue_free()
	battleManager.battleRoster.checkEnemiesAlive()
	emit_signal("reactionComplete")
	queue_free()

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "SnowbroDamaged"):
		emit_signal("reactionComplete")
