extends EntityUI
class_name PlayerUI

var stageManager: StageManager
var player: Entity
var playerPanel

var currentStageAnchor: Control
var currentPanelAnchor: Control

func initialize(stgmn: StageManager, plyrPanel, playerEntity: PlayerEntity, currentAnchors: Array):
	stageManager = stgmn
	player = playerEntity
	playerPanel = plyrPanel
	currentStageAnchor = currentAnchors[player.rosterNumber]
	
	if(stageManager is OverworldManager):
		playerEntity.worldUI = self
		playerPanel.initialize(stageManager, player)
	elif(stageManager is BattleManager):
		playerEntity.battleUI = self
		playerPanel.initialize(stageManager, self, player)
	
	#Set color
	playerPanel.self_modulate = PlayerRoster.rosterColors[playerEntity.rosterNumber]

func centerPlayerPanel():
	if(currentStageAnchor == null):
		printerr("currentStageAnchor not set")
		return
	
	var panelAnchorDiff: Vector2 = currentPanelAnchor.position
	var targetPos = currentStageAnchor.position - panelAnchorDiff
	
	playerPanel.movePanel(targetPos)
