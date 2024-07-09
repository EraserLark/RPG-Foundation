extends Panel

var playerUI

func populateVars(playerUI):
	for node in get_children():
		node.playerUI = playerUI
