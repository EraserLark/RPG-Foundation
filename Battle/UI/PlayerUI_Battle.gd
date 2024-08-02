extends EntityUI
class_name PlayerUI_Battle

@onready var stats:= $PlayerPanel/Stats
@onready var playerMenu:= $PlayerPanel/PlayerMenu
@onready var selectionMenu:= $SelectionMenu
@onready var playerPanel:= $PlayerPanel

var player: PlayerEntity
var battleManager
var currentSelectedAction

func setHP(value):
	stats.changeHealth(value)

func setItems(value):
	playerMenu.itemMenu.populateMenu(value)
