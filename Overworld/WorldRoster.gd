extends EntityRoster
class_name WorldRoster

func _ready():
	super()

func initialize(stgmn: StageManager):
	super(stgmn)

func createEntity(playerInfo: PlayerInfo, playersNode):
	var playerEntity = OWEntity_Player.new()
	playerEntity.entityInfo = playerInfo
	playerInfo.playerWorldEntity = playerEntity
	playerEntity.playerNumber = playerInfo.playerNumber
	playersNode.add_child(playerEntity)
	players.append(playerEntity)

func initializeEntity(playerEntity: Entity, number: int):
	playerEntity.playerNumber = number
	playerEntity.initialize(stageManager, null)
