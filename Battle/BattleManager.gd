extends StageManager
class_name BattleManager

##Scene Path
#Used in static func initBattle to instance battle scene
const battleScene: PackedScene = preload("res://Battle/battle.tscn")

#BattleManager
@export var enemyData: Array[EnemyInfo]
@onready var enemyRoster:= $EnemyRoster
var enemyEntities: Array[BattleEntity_Enemy]
var turnCount:= 0
var xpBank:= 0
var battleIsOver:= false

#Systems
var battleState: Battle_State
@onready var battleStage:= $BattleStage
@onready var cutsceneManager:= $CutsceneManager

#Phases
var promptPhase: GameState_PromptPhase = null
var actionPhase: GameState_ActionPhase = null

#Other
@onready var camera:= $BattleStage/Camera2D

#Workaround for _init() not getting called when instancing scene :P
static func initBattle(_enemyData):
	var newBattle = battleScene.instantiate()
	if(!_enemyData):
		printerr("No Enemy Data supplied!")
	else:
		newBattle.enemyData = _enemyData
	return newBattle

func _ready():
	stageUI = $CanvasLayer/BattleUI
	
	for player in PlayerRoster.getActiveRoster():
		if player.entityInfo.hp > 0:
			player.isDead = false
	
	enemyRoster.initialize(self)
	enemyEntities = enemyRoster.enemies
	stageUI.initialize(self)
	battleStage.initialize(self)
	
	camera.make_current()
	
	battleState = Battle_State.new(self)

func updateTurnCount():
	turnCount += 1
	return turnCount

func checkEnemiesAlive():
	if(enemyRoster.enemies.size() <= 0):
		return false
	else:
		return true

func checkPlayersAlive():
	for player in PlayerRoster.roster:
		if !player.isDead:
			return true
	return false
