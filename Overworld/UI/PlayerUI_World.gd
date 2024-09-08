extends PlayerUI
class_name PlayerUI_World

##Children references
@onready var hpLabel:= $PlayerPanel/MarginContainer/InitialMenu/VBoxContainer/RichTextLabel
@onready var itemsList:= $PlayerPanel/MarginContainer/Submenus/ItemMenu
@onready var playerPanel:= $PlayerPanel
@onready var scrollTimer:= $ScrollTimer

##Parent references
#var owManager: OverworldManager

#func initialize(om: OverworldManager):
	#owManager = om

func setHP(value):
	hpLabel.text = str("HP: ", value, "/", player.entityInfo.hp)

func setItems(value):
	itemsList.populateMenu(value)
