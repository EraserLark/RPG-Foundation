extends Node
class_name BattleManager

#BattleManager
@onready var battleRoster:= $BattleRoster
var playerEntities
var enemyEntities
var turnCount:= 0
var xpBank := 0

#Systems
var battleState: Battle_State
@onready var battleUI:= $CanvasLayer/BattleUI
@onready var battleStage:= $BattleStage
@onready var cutsceneManager:= $CutsceneManager

#Phases
var promptPhase: Prompt_Phase = null
var actionPhase: Action_Phase = null

#Player
@onready var playerActor:= $BattleStage/PlayerActor
@onready var playerUI:= $CanvasLayer/BattleUI/PlayerUI
@onready var playerPanel:= $CanvasLayer/BattleUI/PlayerUI/PlayerPanel

#Other
@onready var camera:= $BattleStage/Camera2D

func _ready():
	playerUI.battleManager = self
	playerPanel.battleManager = self
	battleRoster.battleManager = self
	
	playerEntities = battleRoster.players
	enemyEntities = battleRoster.enemies
	
	for player in playerEntities:
		player.initialize(self)
	
	for enemy in enemyEntities:
		enemy.initialize(self)
	
	camera.make_current()
	
	battleState = Battle_State.new(StateStack, self)
	StateStack.addState(battleState)

func updateTurnCount():
	turnCount += 1
	return turnCount
