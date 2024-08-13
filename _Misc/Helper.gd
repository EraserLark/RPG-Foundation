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
