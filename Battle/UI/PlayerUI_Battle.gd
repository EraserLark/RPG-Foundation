extends EntityUI
class_name PlayerUI_Battle

##Children references
@onready var stats:= $PlayerPanel/Stats
@onready var playerMenu:= $PlayerPanel/PlayerMenu
@onready var selectionMenu:= $SelectionMenu
@onready var playerPanel:= $PlayerPanel

##Outside references
var battleManager: BattleManager
var battleUI: Control
var player: PlayerEntity	#Unused?
var focusAnchor: Control

##Inside vars
#var currentSelectedAction	#Also unused??

func initialize(bm: BattleManager, playerNumber: int, currentAnchors: Array):
	battleManager = bm
	player = battleManager.playerEntities[playerNumber]
	focusAnchor = currentAnchors[playerNumber]
	
	selectionMenu.initialize(battleManager, self)
	playerPanel.initialize(battleManager, self, player)
	
	centerPlayerPanel()

func centerPlayerPanel():
	if(focusAnchor == null):
		printerr("focusAnchor not set")
	var dimensions = getUIDimensions()
	var offset = Vector2(dimensions.x / 2, dimensions.y)
	position = (focusAnchor.position + offset)

func getUIDimensions() -> Vector2:
	return Vector2(playerPanel.size.x, playerPanel.size.y)

func setHP(value):
	stats.changeHealth(value)

func setItems(value):
	playerMenu.itemMenu.populateMenu(value)
