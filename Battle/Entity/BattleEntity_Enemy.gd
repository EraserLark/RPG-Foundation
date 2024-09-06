extends BattleEntity
class_name BattleEntity_Enemy

##Preload vars
var enemyActorScene = preload("res://Battle/2D/EnemyActor.tscn")

##Non export var
var localInfo: EnemyInfo
var enemyActor: BattleActor_Enemy

signal entered

func initialize(sm: StageManager = null):
	super(sm)
	
	#:P This is gross
	localInfo = entityInfo.duplicate_deep_workaround()
	entityInfo = localInfo
	###### EntityInfo is the same as LocalInfo (a duplicate of og EntityInfo resource)
	##This is done to facilitate formatting in parent classes
	
	enemyActor = actor
	
	var enemyAtk = entityInfo.atk
	var enemyAction1 = Attack.new(null, null, "Punch", self, null, Action.TargetTypes.PLAYER, enemyAtk, 0, "")
	var enemyAction2 = Attack.new(null, null, "Bingo", self, null, Action.TargetTypes.PLAYER, enemyAtk + 2, 0, "")
	
	enemyAction1.targetType = Action.TargetTypes.PLAYER
	enemyAction2.targetType = Action.TargetTypes.PLAYER
	
	entityInfo.attackList.append_array([enemyAction1, enemyAction2])
	
	if(enemyActor == null):
		enemyActor = enemyActorScene.instantiate()
		enemyActor = enemyActor
		battleManager.battleStage.enemies.add_child(enemyActor)
	enemyActor.position = Vector2(randi_range(100,1000), randi_range(200,300))
	enemyActor.animPlayer.animation_finished.connect(_on_animation_player_animation_finished)
	enemyActor.sprite.visible = false

func chooseAttack():
	var chosenAction = entityInfo.attackList.pick_random()
	entityInfo.selectedAction = chosenAction
	return chosenAction

func attack():
	enemyActor.attackFeedback()

func checkRoster():
	var result = battleManager.battleRoster.checkEnemiesAlive()
	return result

func entityDead():
	battleManager.battleRoster.enemies.erase(self)
	battleManager.battleRoster.checkEnemiesAlive()
	battleManager.xpBank += entityInfo.xpReward
	super()

func eraseSelectedAction():
	battleManager.actionPhase.actionEQ.queue.erase(entityInfo.selectedAction)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "EnemyDamaged"):
		emit_signal("reactionComplete")
	#elif(anim_name == "Death"):
		#entityDead()
