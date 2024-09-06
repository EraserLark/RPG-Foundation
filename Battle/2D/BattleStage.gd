extends Node2D
class_name BattleStage

##Preload vars
var playerActor = preload("res://Battle/2D/PlayerActor.tscn")
var enemyActor = preload("res://Battle/2D/EnemyActor.tscn")

##Children references
@onready var background:= $Background
@onready var playerSection:= $PlayerActors
@onready var enemySection:= $EnemyActors
@onready var music:= $AudioStreamPlayer2D
@onready var minigameZone:= $MinigameZone
@onready var camera:= $Camera2D

##Parent references
var battleManager: BattleManager

##Inside vars
var playerActors: Array[BattleActor_Player]
var enemyActors: Array[BattleActor_Enemy]

func _ready():
	pass
	#Create blank actors for each player (not assigning any info to them)
	
	#for enemyEntity in PlayerRoster.roster:
		#var playerActorInst = playerActor.instantiate()
		#playerSection.add_child(playerActorInst)
		#playerActors.append(playerActorInst)

func initialize(bm: BattleManager):
	battleManager = bm
	
	#Set up actor information
	var i:=0
	for entity in PlayerRoster.getActiveRoster():	
		var playerActor = addPlayerActor(entity)
		i+=1

func addPlayerActor(pe: PlayerEntity):
	#Create actor, add to tree
	var playerActorInst = playerActor.instantiate()
	playerSection.add_child(playerActorInst)
	#Initialize
	playerActorInst.initialize(pe, self)
	#Add to lists
	playerActors.append(playerActorInst)
	return playerActorInst

func createEnemyActor(enemyData: EnemyInfo) -> BattleActor_Enemy:
	var enemyActorInst = enemyActor.instantiate()
	enemySection.add_child(enemyActorInst)
	enemyActorInst.initialize(enemyData)
	enemyActors.append(enemyActorInst)
	return enemyActorInst
