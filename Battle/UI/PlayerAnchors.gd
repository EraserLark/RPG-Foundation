extends Control
class_name PlayerAnchors

var currentAnchorLayout: Array
var panelAnchorPositions = {}

func _ready():
	determineAnchorLayout()

#{Player #: Anchor #}
func determineAnchorLayout():
	match PlayerRoster.roster.size():
		1:
			currentAnchorLayout = get_child(0).get_children()
			panelAnchorPositions = {0: 4}
		2:
			currentAnchorLayout = get_child(1).get_children()
			panelAnchorPositions = {0: 4, 1: 4}
		3:
			currentAnchorLayout = get_child(2).get_children()
			panelAnchorPositions = {0: 3, 1: 4, 2: 5}
		4:
			currentAnchorLayout = get_child(3).get_children()
			panelAnchorPositions = {0: 3, 1: 5, 2: 3, 3: 5}
		_:
			printerr("Unable to determine anchor layout")

##Panel Anchor Numbers
#0 - Top Left
#1 - Top Middle
#2 - Top Right
#3 - Bottom Left
#4 - Bottom Middle
#5 - Bottom Right
