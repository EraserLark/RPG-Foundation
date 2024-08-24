extends Node
class_name EntityRoster

@onready var players: Array[Entity]
var stageManager: StageManager

func _ready():
	#Set up empty entity nodes for each player (Battle Stage needs this to set up actors before coming back here and initializing roster)
	var playersNode = Node.new()
	playersNode.name = "Players"
	self.add_child(playersNode)
	for player in PlayerRoster.roster:
		createEntity(player, playersNode)

func initialize(stgmn: StageManager):
	stageManager = stgmn
	#Set up info within each player from other systems
	var i:=0
	for playerEntity in players:
		initializeEntity(playerEntity, i)
		i+=1

func createEntity(playerInfo: PlayerInfo, playersNode):
	pass

func initializeEntity(playerEntity: Entity, number: int):
	pass
