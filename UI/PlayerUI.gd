extends EntityUI
class_name PlayerUI

var stageManager: StageManager
var player: Entity

var currentStageAnchor: Control
var currentPanelAnchor: Control

func initialize(stgmn: StageManager, playerPanel, playerEntity: Entity, currentAnchors: Array):
	stageManager = stgmn
	#player = stageManager.playerEntities[playerNumber]
	#currentStageAnchor = currentAnchors[playerNumber]
	player = playerEntity
	currentStageAnchor = currentAnchors[player.playerNumber]
	
	if(stageManager is OverworldManager):
		playerPanel.initialize(stageManager, player)
	elif(stageManager is BattleManager):
		playerPanel.initialize(stageManager, self, player)
	currentPanelAnchor = playerPanel.panelAnchors[4]
	centerPlayerPanel()

func centerPlayerPanel():
	#Only set up for 1 Player atm
	if(currentStageAnchor == null):
		printerr("currentStageAnchor not set")
		return
	
	#var panelAnchorDiff:Vector2 = abs(self.position - currentPanelAnchor.position)
	var panelAnchorDiff: Vector2 = currentPanelAnchor.position
	self.position = currentStageAnchor.position - panelAnchorDiff
	
	#var dimensions = getUIDimensions()
	#var offset = Vector2(dimensions.x / 2, dimensions.y)
	#position = (currentStageAnchor.position + offset)
