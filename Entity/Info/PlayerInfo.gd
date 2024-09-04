extends EntityInfo
class_name PlayerInfo

@export var xp : int
@export var nextLevelCost : int
@export var level : int
@export var money : int
@export var items : Array[String]

var playerNumber: int

##ENTITY
var playerEntity: PlayerEntity: set = setPlayerEntity

func initialize():
	##Create attacks
	var attack1 = Attack.new(null, null, "Basic Attack", null, null, Action.TargetTypes.ENEMY, 1, 0, "res://Battle/Minigames/_Other/TestMinigame.tscn")
	var attack2 = Attack.new(null, null, "Fireball", null, null, Action.TargetTypes.ENEMY, 3, 0, "res://Battle/Minigames/MashMeter/MG_MashMeter.tscn")
	var attack3 = Attack.new(null, null, "Jump Kick", null, null, Action.TargetTypes.ENEMY, 2, 0, "res://Battle/Minigames/Platformer/MG_OneScreenPlatformer.tscn")
	
	attackList += [attack1, attack2, attack3]
	
	##Create items
	var healItem = Item_Heal.new()
	var poisonItem = Item_Poison.new()
	itemList.append_array([healItem, poisonItem])
	
	##Create Misc
	var defend = Defend.new(null, null, playerEntity, Action.TargetTypes.PLAYER, null)
	miscList.append(defend)


func takeDamage(dmg: int):
	super(dmg)
	emit_signal("healthRemaining", hp)

func addHealth(amt: int):
	super(amt)

func levelUp():
	level += 1
	xp -= nextLevelCost
	nextLevelCost += 5

func setupAttacks(stgmn: StageManager):
	for attack in attackList:
		attack.setManager(stgmn)

func setupItems(stgmn: StageManager):
	for item in itemList:
		item.itemAction.setManager(stgmn)

func setupMisc(stgmn: StageManager):
	for action in miscList:
		action.setManager(stgmn)

func setPlayerEntity(value):
	playerEntity = value
	#if playerEntity.battleUI == null:
		#entityUI = playerEntity.worldUI
	#else:
		#entityUI = playerEntity.battleUI

func setPlayerEntityUI(value):
	entityUI = value
