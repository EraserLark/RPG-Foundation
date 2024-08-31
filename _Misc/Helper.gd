@tool
extends Node
class_name Helper

static func removeIndex(array: Array, index: int) -> Array:
	var arrayDup:= array.duplicate()
	arrayDup.remove_at(index)
	return arrayDup

static func append(array: Array, item) -> Array:
	var arrayDup:= array.duplicate()
	arrayDup.append(item)
	return arrayDup

static func arrayToString(array: Array[String], seperator=",") -> String:
	var string = ""
	for i in array:
		string += str(i)+seperator
	return string

static func getAllChildren(rootNode: Node) -> Array:
	var nodes: Array = []
	for N in rootNode.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			nodes.append_array(getAllChildren(N))
		else:
			nodes.append(N)
	return nodes


static var directions = [
	Vector2.LEFT,
	Vector2.LEFT + Vector2.UP,
	Vector2.UP,
	Vector2.RIGHT + Vector2.UP,
	Vector2.RIGHT,
	Vector2.RIGHT + Vector2.DOWN,
	Vector2.DOWN,
	Vector2.LEFT + Vector2.DOWN
	]

static func convertToEightDir(inputDir: Vector2):
	##Rotating inputDir vector by 1/16th of a circle (PI in radians is half a circle, then divided by 8)
	##Offsetting the zones in the circle so 8 dir vectors cross through zone middles
	var rotatedInput = inputDir.rotated(PI / 8.0)
	##Getting the angle of that Vector in radians
	var vectorAngle = rotatedInput.angle()
	##Adding PI to that angle (Add half circle to it)
	vectorAngle += PI
	##Multiplying that angle by 8
	vectorAngle *= 8
	##Dividing that angle by Tau
	vectorAngle /= TAU
	##Finally casting it to an int
	var direction_id = int(vectorAngle)
	#var direction_id = int(8.0 * (inputDir.rotated(PI / 8.0).angle() + PI) / TAU)
	var direction = directions[direction_id].normalized()
	return direction
