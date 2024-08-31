extends Node

var ui
var world
var tbContainer_Stage
var tbContainer_PlayerPanel
var cutsceneMarkers

@export var roomsList = {}

func startTimeline(timelinePath: String, playerNum: int):
	var playerEntity: OWEntity_Player = PlayerRoster.roster[playerNum]
	#Instantiate timeline, parent it under proper player node here
	var tl = load(timelinePath)
	var inst = tl.instantiate()	##If crashing here: Timeline path is not valid
	playerEntity.add_child(inst)
	#Have the proper player's DialogueManager start the timeline
	playerEntity.dialogueManager.startDialogue(inst)

func updateOWVars(newUI, newWorld):
	ui = newUI
	world = newWorld
	tbContainer_Stage = ui.tbContainer
	if(!ui.playerUIRoster.is_empty):
		tbContainer_PlayerPanel = ui.playerUIRoster[0].playerPanel
	cutsceneMarkers = world.currentRoom.cutsceneMarks
