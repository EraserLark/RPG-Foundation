@tool
extends HBoxContainer
class_name ResponseListing

@onready var cursorZone:= $CenterContainer
@onready var label:= $Label

@export var responseText: String: set = setLabel

func setLabel(text):
	$Label.text = text
