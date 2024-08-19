extends Node2D
class_name CutsceneMarks

var marksArray: Array[Node2D]
var pathsArray: Array[Path2D]

func _ready():
	for child in get_children():
		if child is Path2D:
			pathsArray.append(child)
		elif child is Node2D:
			marksArray.append(child)
