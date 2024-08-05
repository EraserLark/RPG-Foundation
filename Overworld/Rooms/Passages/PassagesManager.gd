extends Node2D
class_name PassagesManager

func getSpawnPoint(spawnPort: int) -> Vector2:
	var spawn = get_child(spawnPort).spawnPoint.global_position
	return spawn

func getSpawnDir(spawnPort: int) -> Vector2:
	var enumDir = get_child(spawnPort).spawnFacing
	var angRad = deg_to_rad(enumDir * 45)
	var xDir = cos(angRad)
	var yDir = -sin(angRad)
	var dir = Vector2(xDir,yDir)
	return dir