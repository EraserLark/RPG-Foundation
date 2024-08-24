extends Node

var ui
var world
var tbContainer_Stage
var tbContainer_PlayerPanel
var cutsceneMarkers

#var player1Node: Node

@export var roomsList = {}

##Will need to refactor for multiplayer
func _ready():
	pass
	#player1Node = Node.new()
	#player1Node.name = "Player1"
	#add_child(player1Node)

func startTimeline(timelinePath: String, playerNum: int):
	var playerEntity: OWEntity_Player = world.owManager.playerEntities[playerNum]
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
	tbContainer_PlayerPanel = ui.playerUIRoster[0].playerPanel
	cutsceneMarkers = world.currentRoom.cutsceneMarks
