extends Node

@onready var enemies : Array[EnemyEntity]

func _ready():
	var enemyNodes = get_node("Enemies").get_children()
	
	for enemyNode in enemyNodes:
		enemies.append(enemyNode.getClassInstance())
