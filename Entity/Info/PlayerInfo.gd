extends EntityInfo
class_name PlayerInfo

@export var xp : int
@export var nextLevelCost : int
@export var level : int
@export var money : int
@export var items : Array[String]

var playerNumber: int
var dialogueManager:= DialogueManager.new()

##BATTLE
var playerEntity

##OVERWORLD
var playerActor: OW_Player
var owPlayerState: Player_Active

func _ready():
	print("Stall")

func takeDamage(dmg: int):
	super(dmg)
	emit_signal("healthRemaining", hp)

func addHealth(amt: int):
	super(amt)

func levelUp():
	level += 1
	xp -= nextLevelCost
	nextLevelCost += 5

func setupAttacks(bm: BattleManager):
	var attack1 = Attack.new(null, bm, "Basic Attack", null, null, Action.TargetTypes.ENEMY, 1, 0, "res://Battle/Minigames/_Other/TestMinigame.tscn")
	var attack2 = Attack.new(null, bm, "Fireball", null, null, Action.TargetTypes.ENEMY, 3, 0, "res://Battle/Minigames/MashMeter/MG_MashMeter.tscn")
	var attack3 = Attack.new(null, bm, "Jump Kick", null, null, Action.TargetTypes.ENEMY, 2, 0, "res://Battle/Minigames/Platformer/MG_OneScreenPlatformer.tscn")
	
	actionList += [attack1, attack2, attack3]

func setupItems(bm: BattleManager):
	var healItem = Item_Heal.new(bm)
	var poisonItem = Item_Poison.new(bm)
	itemList.append_array([healItem, poisonItem])

func setupMisc(bm: BattleManager):
	var defend = Defend.new(null, null, playerEntity, Action.TargetTypes.PLAYER, bm)
	miscList.append(defend)

##OVERWORLD
func setActor(newActor: OW_Player):
	playerActor = newActor
	owPlayerState.player = playerActor
