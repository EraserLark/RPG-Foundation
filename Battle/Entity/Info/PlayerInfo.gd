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

func setupAttacks():
	var attack1 = Attack.new(null, "Basic Attack", null, null, 1, 0)
	var attack2 = Attack.new(null, "Fireball", null, null, 3, 0)
	var attack3 = Attack.new(null, "Uppercut", null, null, 2, 0)
	
	actionList += [attack1, attack2, attack3]

func setupItems():
	var healItem = Item_Heal.new()
	var poisonItem = Item_Poison.new()
	itemList.append_array([healItem, poisonItem])

func setupMisc():
	var defend = Defend.new(null, null, playerEntity)
	miscList.append(defend)
