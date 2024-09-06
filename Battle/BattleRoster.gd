extends EntityRoster
class_name BattleRoster

##Parent references
var battleManager

##Non export vars
@onready var enemies: Array[BattleEntity_Enemy]

func _ready():
	super()

func createEntity(playerInfo: PlayerInfo):
	var playerEntity = BattleEntity_Player.new()
	playerEntity.entityInfo = playerInfo
	playerEntity.playerNumber = playerInfo.playerNumber
	playersNode.add_child(playerEntity)
	players.append(playerEntity)

func initialize(stgmn: StageManager):
	battleManager = stgmn
	
	var enemiesNode = Node.new()
	enemiesNode.name = "Enemies"
	self.add_child(enemiesNode)
	
	super(battleManager)	#assign actors, initialize entities
	
	for enemyData in battleManager.enemyData:
		#Create entity node, add to tree
		var enemyEntity = BattleEntity_Enemy.new()
		enemiesNode.add_child(enemyEntity)
		enemyEntity.entityInfo = enemyData
		#Create and assign enemy actor
		var enemyInstActor = battleManager.battleStage.createEnemyActor(enemyData)
		enemyEntity.actor = enemyInstActor
		#Initialize
		enemyEntity.initialize(battleManager)
		#Add to lists
		enemies.append(enemyEntity)

func initializeEntity(playerEntity: Entity):
	playerEntity.actor = battleManager.battleStage.playerActors[playerEntity.playerNumber]
	playerEntity.initialize(battleManager)

#func checkEnemiesAlive():
	#if(enemies.size() <= 0):
		#return false
	#else:
		#return true
#
#func checkPlayersAlive():
	#for player in battleManager.playerEntities:
		#if !player.isDead:
			#return true
	#return false
	#if(players.size() <= 0):
		#return false
	#else:
		#return true
