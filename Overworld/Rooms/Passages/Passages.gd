extends Node2D
class_name PassagesManager

func getSpawnPoint(spawnPort: int):
	var spawn = get_child(spawnPort).spawnPoint.global_position
	return spawn
