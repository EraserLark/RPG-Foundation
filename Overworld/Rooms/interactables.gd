extends Node2D

func initialize(om: OverworldManager, rm: Room):
	for interactable in self.get_children():
		if interactable is Sign:
			interactable.worldUI = om.stageUI
		elif interactable is Area2D:
			interactable.owManager = om
