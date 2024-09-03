extends CharacterBody2D
class_name OW_Enemy

##Scene path
var battleScenePath = "res://Battle/battle.tscn"

##Children references
#None

##Parent references
var player: OW_Player
var world
var room: Room

##Export vars
@export var battleData: Array[EnemyInfo]

func initialize(om: OverworldManager, rm: Room):
	world = om.overworldWorld
	room = rm
	player = rm.castList.find_child("OW_Player")

func interactAction(interacter : OW_Player):
	var enterBattleState = Player_EnterBattle.new({"Room": room, "EnemyData": battleData})
	#GameStateStack.stack.addState(enterBattleState, )
