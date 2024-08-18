extends EntityUI
class_name PlayerUI_World

##Children references
@onready var hpLabel:= $PlayerMenu/MarginContainer/InitialMenu/VBoxContainer/RichTextLabel
@onready var itemsList:= $PlayerMenu/MarginContainer/Submenus/ItemMenu

##Parent references
var owManager: OverworldManager

func initialize(om: OverworldManager):
	owManager = om

func setHP(value):
	hpLabel.text = str("HP: ", value, "/", owManager.player.playerInfo.hp)

func setItems(value):
	itemsList.populateMenu(value)
