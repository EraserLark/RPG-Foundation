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

##Inside vars
#var currentSelectedAction	#Also unused??

func initialize(bm: BattleManager, playerNumber: int):
	battleManager = bm
	player = battleManager.playerEntities[playerNumber]
	
	selectionMenu.initialize(battleManager, self)
	playerPanel.initialize(battleManager, self, player)

func setHP(value):
	stats.changeHealth(value)

func setItems(value):
	playerMenu.itemMenu.populateMenu(value)
