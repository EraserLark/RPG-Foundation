extends Node
class_name Helper

static func removeIndex(array: Array, index: int) -> Array:
	var arrayDup:= array.duplicate()
	arrayDup.remove_at(index)
	return arrayDup

static func append(array: Array, item):
	var arrayDup:= array.duplicate()
	arrayDup.append(item)
	return arrayDup
