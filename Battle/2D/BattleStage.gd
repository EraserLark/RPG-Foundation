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
	#Create blank actors for each player (not assigning any info to them)
	for playerEntity in PlayerRoster.roster:
		var playerActorInst = playerActor.instantiate()
		playerSection.add_child(playerActorInst)
		playerActors.append(playerActorInst)
	
	for enemyEntity in PlayerRoster.roster:
		var playerActorInst = playerActor.instantiate()
		playerSection.add_child(playerActorInst)
		playerActors.append(playerActorInst)

func initialize(bm: BattleManager):
	battleManager = bm
	
	#Set up actor information
	var i:=0
	for playerActor in playerActors:
		playerActor.initialize(battleManager, self, i)
		i+=1

func createEnemyActor(enemyData: EnemyInfo) -> BattleActor_Enemy:
	var enemyActorInst = enemyActor.instantiate()
	enemySection.add_child(enemyActorInst)
	enemyActorInst.initialize(enemyData)
	enemyActors.append(enemyActorInst)
	return enemyActorInst
