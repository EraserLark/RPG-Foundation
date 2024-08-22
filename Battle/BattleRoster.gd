extends Node
class_name BattleRoster

##Parent references
var battleManager

##Non export vars
@onready var enemies: Array[BattleEntity_Enemy]
@onready var players: Array[BattleEntity_Player]

func _ready():
	#Set up empty entity nodes for each player (Battle Stage needs this to set up actors before coming back here and initializing roster)
	var playersNode = get_node("Players")
	for player in PlayerRoster.roster:
		var playerEntity = BattleEntity_Player.new()
		playerEntity.entityInfo = player
		playerEntity.playerNumber = player.playerNumber
		playersNode.add_child(playerEntity)
		players.append(playerEntity)

func initialize(bm: BattleManager):
	battleManager = bm
	
	var enemiesNode = get_node("Enemies")
	#
	#for enemyNode in enemyNodes:
		#enemies.append(enemyNode.getClassInstance())
	
	#Set up info within each player from other systems
	var i:=0
	for playerEntity in players:
		playerEntity.actor = battleManager.battleStage.playerActors[i]
		playerEntity.initialize(battleManager)
		i+=1
	
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

func checkEnemiesAlive():
	if(enemies.size() <= 0):
		return false
	else:
		return true

func checkPlayersAlive():
	if(players.size() <= 0):
		return false
	else:
		return true
