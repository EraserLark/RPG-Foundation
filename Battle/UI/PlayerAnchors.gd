extends Control
class_name PlayerAnchors

var currentAnchorLayout: Array
var panelAnchorPositions = {}
var panelAttachmentsFlip = {}

func _ready():
	determineAnchorLayout()

#panelAnchorPositions = {Player #: Anchor #}
#panelAttachmentsFlip = {Player #: [flipHealthbar, flipActionButtons]}
func determineAnchorLayout():
	match PlayerRoster.roster.size():
		1:
			currentAnchorLayout = get_child(0).get_children()
			panelAnchorPositions = {0: 4}
			panelAttachmentsFlip = {0: [false, false]}
		2:
			currentAnchorLayout = get_child(1).get_children()
			panelAnchorPositions = {0: 4, 1: 4}
			panelAttachmentsFlip = {0: [false, false], 1: [false, false]}
		3:
			currentAnchorLayout = get_child(2).get_children()
			panelAnchorPositions = {0: 3, 1: 4, 2: 5}
			panelAttachmentsFlip = {0: [true, false], 1: [false, false], 2: [false, false]}
		4:
			currentAnchorLayout = get_child(3).get_children()
			panelAnchorPositions = {0: 0, 1: 2, 2: 3, 3: 5}
			panelAttachmentsFlip = {0: [true, true], 1: [false, true], 2: [true, false], 3: [false, false]}
		_:
			printerr("Unable to determine anchor layout")

##Panel Anchor Numbers
#0 - Top Left
#1 - Top Middle
#2 - Top Right
#3 - Bottom Left
#4 - Bottom Middle
#5 - Bottom Right
