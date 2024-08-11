@tool
extends HBoxContainer
class_name ResponseListing

@onready var cursorZone:= $CenterContainer
@onready var label:= $Label

@export var responseText: String: set = setLabel
@export var labelMaxSize: int = 100

func setLabel(text):
	responseText = text
	if !is_inside_tree():
		await self.ready
	elif is_inside_tree():
		$Label.text = text
		resizeLabel()

func resizeLabel():
	var strPixelLength = label.get_theme_font("font").get_string_size(label.text).x
	if(strPixelLength < labelMaxSize):
		label.set_custom_minimum_size(Vector2(strPixelLength, 0))
	else:
		label.set_custom_minimum_size(Vector2(labelMaxSize, 0))
