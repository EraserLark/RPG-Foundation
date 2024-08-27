extends Event
class_name Action

var sender# : Entity
var target# : Entity
var targetOptions: Array
var entityTargetLists: Array	#An array of entity arrays. 0 = Players, 1 = Enemies
#var battleManager: BattleManager
var stageManager: StageManager
var actionMinigame	#Used in Attack class
enum TargetTypes {PLAYER, ENEMY, ALL}
var targetType: TargetTypes

func _init(eManager: EventQueue, send: Entity, targ: Entity, targType, stgmn: StageManager):
	super(eManager)
	sender = send
	target = targ
	targetType = targType
	stageManager = stgmn

func setManager(manager: StageManager):
	stageManager = manager

func setupTargetOptions():
	match targetType:
		TargetTypes.PLAYER:
			if stageManager.playerEntities.is_empty():
				printerr("No players to target")
				return
			else:
				targetOptions = stageManager.playerEntities
		TargetTypes.ENEMY:
			if stageManager.enemyEntities.is_empty():
				printerr("No enemies to target")
				return
			else:
				targetOptions = stageManager.enemyEntities
		TargetTypes.ALL:
			if stageManager.playerEntities.is_empty():
				printerr("No players to target")
				return
			elif stageManager.enemyEntities.is_empty():
				printerr("No enemies to target")
				return
			else:
				targetOptions += stageManager.playerEntities
				targetOptions += stageManager.enemyEntities
