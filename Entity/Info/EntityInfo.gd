extends Resource
class_name EntityInfo

@export var entityName: String
@export var hp: int : set = setHP
@export var hpMax: int
@export var atk: int
@export var def: int
@export var sprite: Texture

#var owner
var actionList: Array[Action]
var itemList: Array[Item] : set = setItems
var miscList: Array[Action]
var selectedAction: Action

var animPlayer: AnimationPlayer
var audioPlayer: AudioStreamPlayer2D
var animFinished: bool = false
var audioFinished: bool = false

var entityUI: EntityUI

signal damageTaken(dmg)
signal healthRemaining(health)

func setHP(value):
	hp = value
	if(entityUI != null):
		entityUI.setHP(hp)

func setItems(value):
	itemList = value
	if(entityUI != null):
		entityUI.setItems(itemList)

func calcDamage(dmg : int):
	var trueDmg := dmg-def
	if(trueDmg < 0):
		trueDmg = 0
	
	return trueDmg

func takeDamage(dmg : int):
	hp -= dmg
	if(hp < 0):
		hp = 0

func addHealth(amt : int):
	hp += amt
	if(hp > hpMax):
		hp = hpMax

func duplicate_deep_workaround() -> EntityInfo:
	var dup: EntityInfo = duplicate(true) as EntityInfo
	for i: int in dup.actionList.size():
		dup.actionList[i] = dup.actionList[i].duplicate(true)
	for i: int in dup.itemList.size():
		dup.itemList[i] = dup.itemList[i].duplicate(true)
	for i: int in dup.miscList.size():
		dup.miscList[i] = dup.miscList[i].duplicate(true)
	return dup
