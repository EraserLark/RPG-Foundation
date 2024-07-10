extends Node

var battleManager

@onready var enemies : Array[EnemyEntity]

func _ready():
	var enemyNodes = get_node("Enemies").get_children()
	
	for enemyNode in enemyNodes:
		enemies.append(enemyNode.getClassInstance())

func checkEnemiesAlive():
	if(enemies.size() <= 0):
		battleManager.battleState.eventQueue.currentEvent.battleOver()
