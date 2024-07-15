extends Event
class_name Action

var sender# : Entity
var target# : Entity
var targetOptions : Array
var battleManager : BattleManager

enum TargetTypes {PLAYER, ENEMY, ALL}
var targetType : TargetTypes

func _init(eManager, send, targ, targType, bm):
	super(eManager)
	sender = send
	target = targ
	targetType = targType
	battleManager = bm

func setupTargetOptions():
	match targetType:
		TargetTypes.PLAYER:
			targetOptions = battleManager.playerEntities
		TargetTypes.ENEMY:
			targetOptions = battleManager.enemyEntities
		TargetTypes.ALL:
			targetOptions += battleManager.playerEntities
			targetOptions += battleManager.enemyEntities
