extends EntityUI
class_name PlayerUI_Battle

##Children references
@onready var stats:= $PlayerPanel/Stats
@onready var playerMenu:= $PlayerPanel/PlayerMenu
@onready var selectionMenu:= $SelectionMenu
@onready var playerPanel:= $PlayerPanel
@onready var animPlayer:= $AnimationPlayer

##Outside references
var battleManager: BattleManager
var battleUI: Control
var player: BattleEntity_Player
var currentStageAnchor: Control

##Inside vars
var currentPanelAnchor: Control

func initialize(bm: BattleManager, playerNumber: int, currentAnchors: Array):
	battleManager = bm
	player = battleManager.playerEntities[playerNumber]
	currentStageAnchor = currentAnchors[playerNumber]
	
	selectionMenu.initialize(battleManager, self)
	playerPanel.initialize(battleManager, self, player)
	
	#Bottom center panel anchor
	currentPanelAnchor = playerPanel.panelAnchors[4]
	centerPlayerPanel()

func centerPlayerPanel():
	#Only set up for 1 Player atm
	if(currentStageAnchor == null):
		printerr("currentStageAnchor not set")
		return
	
	var panelAnchorDiff:Vector2 = abs(self.position - currentPanelAnchor.position)
	self.position = currentStageAnchor.position - panelAnchorDiff
	
	#var dimensions = getUIDimensions()
	#var offset = Vector2(dimensions.x / 2, dimensions.y)
	#position = (currentStageAnchor.position + offset)

func getUIDimensions() -> Vector2:
	return Vector2(playerPanel.size.x, playerPanel.size.y)

func setHP(value):
	stats.changeHealth(value)

func setItems(value):
	playerMenu.itemMenu.populateMenu(value)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "PlayerDeath"):
		player.entityDead()
	else:
		player.emit_signal("reactionComplete")
