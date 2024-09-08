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

func _init(eManager: EventQueue, send, targ, targType, stgmn: StageManager):
	super(eManager)
	sender = send
	target = targ
	targetType = targType
	stageManager = stgmn

func setManager(manager: StageManager):
	stageManager = manager

func runEvent():
	#If target dies before you run your action, reset target
	if target == null or target.isDead:
		setupTargetOptions()
		target = targetOptions[0]

func setupTargetOptions():
	match targetType:
		TargetTypes.PLAYER:
			if PlayerRoster.getLivingRoster().is_empty():
				printerr("No players to target")
				return
			else:
				targetOptions = PlayerRoster.getLivingRoster()
		TargetTypes.ENEMY:
			if stageManager.enemyEntities.is_empty():
				printerr("No enemies to target")
				return
			else:
				targetOptions = stageManager.enemyEntities
		TargetTypes.ALL:
			if PlayerRoster.getLivingRoster().is_empty():
				printerr("No players to target")
				return
			elif stageManager.enemyEntities.is_empty():
				printerr("No enemies to target")
				return
			else:
				targetOptions += PlayerRoster.getLivingRoster()
				targetOptions += stageManager.enemyEntities
