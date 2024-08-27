extends Node
class_name EntityRoster

@onready var players: Array[Entity]
var stageManager: StageManager
var playersNode: Node	#Node that all players are organized into

func _ready():
	pass
	##Set up empty entity nodes for each player (Battle Stage needs this to set up actors before coming back here and initializing roster)
	#playersNode = Node.new()
	#playersNode.name = "Players"
	#self.add_child(playersNode)
	#for player in PlayerRoster.roster:
		#createEntity(player)

func initialize(stgmn: StageManager):
	pass
	#stageManager = stgmn
	##Set up info within each player from other systems
	#var i:=0
	#for playerEntity in players:
		#initializeEntity(playerEntity)
		#i+=1

func createEntity(playerInfo: PlayerInfo):
	pass

func initializeEntity(playerEntity: Entity):
	pass
