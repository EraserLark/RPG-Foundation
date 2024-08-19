extends Entity
class_name EnemyEntity

##Preload vars
var enemyActorScene = preload("res://Battle/2D/EnemyActor.tscn")

##Non export var
var enemyActor: BattleActor_Enemy

signal entered

func initialize(bm: BattleManager):
	super(bm)
	
	enemyActor = actor
	
	var enemyAtk = localInfo.atk
	var enemyAction1 = Attack.new(null, bm, "Punch", self, null, Action.TargetTypes.PLAYER, enemyAtk, 0, "")
	var enemyAction2 = Attack.new(null, bm, "Bingo", self, null, Action.TargetTypes.PLAYER, enemyAtk + 2, 0, "")
	
	enemyAction1.targetType = Action.TargetTypes.PLAYER
	enemyAction2.targetType = Action.TargetTypes.PLAYER
	
	localInfo.actionList.append_array([enemyAction1, enemyAction2])
	
	if(enemyActor == null):
		enemyActor = enemyActorScene.instantiate()
		enemyActor = enemyActor
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

func checkRoster():
	var result = battleManager.battleRoster.checkEnemiesAlive()
	return result

func entityDead():
	battleManager.battleRoster.enemies.erase(self)
	battleManager.battleRoster.checkEnemiesAlive()
	battleManager.xpBank += localInfo.xpReward
	super()

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "SnowbroDamaged"):
		emit_signal("reactionComplete")
	#elif(anim_name == "Death"):
		#entityDead()
