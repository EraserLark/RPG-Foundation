extends CharacterBody2D
class_name OW_Enemy

##Scene path
var battleScenePath = "res://Battle/battle.tscn"

##Children references
#None

##Parent references
var player: OW_Player
var world

##Export vars
@export var battleData: Array[EnemyInfo]

func initialize(om: OverworldManager, rm: Room):
	world = om.overworldWorld
	player = rm.castList.find_child("OW_Player")

func interactAction(interacter : OW_Player):
	world.pauseWorld()
	var inst = BattleManager.initBattle(battleData)
	get_node("/root").add_child(inst)
