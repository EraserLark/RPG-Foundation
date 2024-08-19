extends Node

##Parent references
var battleManager

##Non export vars
@onready var enemies: Array[EnemyEntity]
@onready var players: Array[PlayerEntity]

func initialize(bm: BattleManager):
	battleManager = bm
	
	var enemyNodes = get_node("Enemies").get_children()
	#var playerNodes = get_node("Players").get_children()
	var playersNode = get_node("Players")
	
	for enemyNode in enemyNodes:
		enemies.append(enemyNode.getClassInstance())
	
	#for playerNode in playerNodes:
		#players.append(playerNode.getClassInstance())
	
	for player in PlayerRoster.roster:
		var playerEntity = PlayerEntity.new()
		playersNode.add_child(playerEntity)
		playerEntity.entityInfo = player
		battleManager.playerEntities.append(playerEntity)
		playerEntity.initialize(battleManager)
		battleManager.playerEntities[0].localInfo.entityUI = battleManager.playerUI

func checkEnemiesAlive():
	if(enemies.size() <= 0):
		return false
	else:
		return true

func checkPlayersAlive():
	if(players.size() <= 0):
		return false
	else:
		return true
