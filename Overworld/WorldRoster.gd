extends EntityRoster
class_name WorldRoster

func _ready():
	super()

func initialize(stgmn: StageManager):
	super(stgmn)

func createEntity(playerInfo: PlayerInfo):
	var playerEntity = OWEntity_Player.new()
	playerEntity.entityInfo = playerInfo
	playerInfo.playerWorldEntity = playerEntity
	playerEntity.playerNumber = playerInfo.playerNumber
	playersNode.add_child(playerEntity)
	players.append(playerEntity)
	return playerEntity

func initializeEntity(playerEntity: Entity):
	playerEntity.initialize(stageManager, null)

func addNewEntity(playerInfo: PlayerInfo, emptyUI: PlayerUI_World):
	var newEntity = createEntity(playerInfo)
	stageManager.overworldWorld.currentRoom.castList.addActor(newEntity)
	stageManager.overworldUI.initializePlayerUI(emptyUI, newEntity)
	initializeEntity(newEntity)
