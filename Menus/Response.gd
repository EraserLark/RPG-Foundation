#@tool
extends HBoxContainer
class_name ResponseListing

@onready var cursorZone:= $CenterContainer
@onready var label:= $Label

@export var responseText: String: set = setLabel

func setLabel(text):
	responseText = text
	if is_inside_tree():
		$Label.text = text
