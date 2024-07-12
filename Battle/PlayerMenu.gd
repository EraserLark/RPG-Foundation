extends Panel

var playerUI

func populateVars(pUI):
	for node in get_children():
		node.playerUI = pUI
