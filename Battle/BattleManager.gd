extends StageManager
class_name BattleManager

##Scene Path
const battleScene: PackedScene = preload("res://Battle/battle.tscn")

#BattleManager
@export var enemyData: Array[EnemyInfo]
@onready var battleRoster:= $BattleRoster
var playerEntities: Array[BattleEntity_Player]
var enemyEntities: Array[BattleEntity_Enemy]
var turnCount:= 0
var xpBank:= 0

#Systems
var battleState: Battle_State
@onready var battleUI:= $CanvasLayer/BattleUI
@onready var battleStage:= $BattleStage
@onready var cutsceneManager:= $CutsceneManager

#Phases
var promptPhase: Prompt_Phase = null
var actionPhase: Action_Phase = null

#Player
@onready var playerActors:= $BattleStage/PlayerActors
#@onready var playerUI:= $CanvasLayer/BattleUI/PlayerUI
#@onready var playerPanel:= $CanvasLayer/BattleUI/PlayerUI/PlayerPanel

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
	#playerUI.battleManager = self
	#playerPanel.battleManager = self
	#battleRoster.battleManager = self
	playerEntities.assign(battleRoster.players)
	
	battleRoster.initialize(self)
	enemyEntities = battleRoster.enemies
	battleUI.initialize(self)
	battleStage.initialize(self)
	
	#for player in playerEntities:
		#player.initialize(self)
	
	#for enemy in enemyEntities:
		#enemy.initialize(self)
	
	#playerPanel.initialize()
	
	camera.make_current()
	
	battleState = Battle_State.new(StateStack, self)
	StateStack.addState(battleState)

func updateTurnCount():
	turnCount += 1
	return turnCount
