extends Node

var battleManager

@onready var enemies: Array[EnemyEntity]
@onready var players: Array[PlayerEntity]

func _ready():
	var enemyNodes = get_node("Enemies").get_children()
	var playerNodes = get_node("Players").get_children()
	
	for enemyNode in enemyNodes:
		enemies.append(enemyNode.getClassInstance())
	
	for playerNode in playerNodes:
		players.append(playerNode.getClassInstance())

func checkEnemiesAlive():
	if(enemies.size() <= 0):
		#battleManager.battleState.battleEQ.currentEvent.battleOver()
		return false
	else:
		return true

func checkPlayersAlive():
	if(players.size() <= 0):
		#battleManager.battleState.battleEQ.currentEvent.battleOver()
		return false
	else:
		return true
