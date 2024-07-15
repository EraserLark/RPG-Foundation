extends EntityInfo
class_name PlayerInfo

@export var xp : int
@export var money : int
@export var items : Array[String]

var playerEntity

func _ready():
	pass

func takeDamage(dmg : int):
	super(dmg)
	emit_signal("healthRemaining", hp)

func addHealth(amt : int):
	super(amt)

func setupAttacks(bm : BattleManager):
	var attack1 = Attack.new(null, bm, "Basic Attack", null, null, Action.TargetTypes.ENEMY, 1, 0)
	var attack2 = Attack.new(null, bm, "Fireball", null, null, Action.TargetTypes.ENEMY, 3, 0)
	var attack3 = Attack.new(null, bm, "Uppercut", null, null, Action.TargetTypes.ENEMY, 2, 0)
	
	actionList += [attack1, attack2, attack3]

func setupItems(bm : BattleManager):
	var healItem = Item_Heal.new(bm)
	var poisonItem = Item_Poison.new(bm)
	itemList.append_array([healItem, poisonItem])

func setupMisc(bm : BattleManager):
	var defend = Defend.new(null, null, playerEntity, Action.TargetTypes.PLAYER, bm)
	miscList.append(defend)
