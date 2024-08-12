extends Node

var ui
var world
var tbContainer_Stage
var tbContainer_PlayerPanel
var cutsceneMarkers

var player1Node: Node

##Will need to refactor for multiplayer
func _ready():
	player1Node = Node.new()
	player1Node.name = "Player1"
	add_child(player1Node)

func startTimeline(timeline: PackedScene, playerNum: int):
	#Instantiate timeline, parent it under proper player node here
	var tl = timeline.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	player1Node.add_child(tl)
	
	#Have the proper player's DialogueManager start the timeline
	PlayerRoster.roster[0].dialogueManager.startDialogue(tl)

func updateOWVars(newUI, newWorld):
	ui = newUI
	world = newWorld
	tbContainer_Stage = ui.tbContainer
	tbContainer_PlayerPanel = ui.playerMenu
	cutsceneMarkers = world.currentRoom.cutsceneMarks
