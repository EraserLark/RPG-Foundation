extends Control
class_name PlayerAnchors

var currentAnchorLayout: Array

func _ready():
	determineAnchorLayout()

func determineAnchorLayout():
	match PlayerRoster.roster.size():
		1:
			currentAnchorLayout = get_child(0).get_children()
		_:
			printerr("Unable to determine anchor layout")
