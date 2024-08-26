extends Control
class_name PlayerAnchors

var currentAnchorLayout: Array
var panelAnchorPositions = {}

func _ready():
	determineAnchorLayout()

func determineAnchorLayout():
	match PlayerRoster.roster.size():
		1:
			currentAnchorLayout = get_child(0).get_children()
			panelAnchorPositions = {0: 4}
		2:
			currentAnchorLayout = get_child(1).get_children()
			panelAnchorPositions = {0: 4, 1: 4}
		_:
			printerr("Unable to determine anchor layout")

##Panel Anchor Numbers
#0 - Top Left
#1 - Top Middle
#2 - Top Right
#3 - Bottom Left
#4 - Bottom Middle
#5 - Bottom Right
