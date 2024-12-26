extends EntityUI
class_name PlayerUI

var stageManager: StageManager
var player: Entity
var playerPanel: PlayerPanel

var currentStageAnchor: Control
var currentPanelAnchor: Control
var panelAnchorNum: int
var stageAnchorNum: int

func emptyPanel():
	playerPanel.playerUI = self		#Stinky
	playerPanel.position = currentStageAnchor.position + Vector2(0, playerPanel.panel.size.y)

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
	playerPanel.panel.self_modulate = PlayerRoster.rosterColors[playerEntity.rosterNumber]

func updatePanelAnchors(slotNumber: int):
	#Use slot num b/c emptyUI won't have a player to grab player numb from yet
	var panelAnchorIndex = stageManager.stageUI.playerAnchors.panelAnchorPositions[slotNumber]
	currentPanelAnchor = playerPanel.panelAnchors[panelAnchorIndex]
	panelAnchorNum = panelAnchorIndex
	currentStageAnchor = stageManager.stageUI.playerAnchors.currentAnchorLayout[slotNumber]
	stageAnchorNum = slotNumber

#Move player panel to currentStageAnchor
func migratePlayerPanel():
	if(currentStageAnchor == null):
		printerr("currentStageAnchor not set")
		return
	
	#var panelAnchorDiff: Vector2 = currentPanelAnchor.position
	var targetPos = currentStageAnchor.position #- Vector2(0, panelAnchorDiff.y/2)
	
	playerPanel.movePanel(targetPos)
