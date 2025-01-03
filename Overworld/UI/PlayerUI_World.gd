extends PlayerUI
class_name PlayerUI_World

##Children references
@onready var hpLabel:= $PlayerPanel/Panel/MarginContainer/InitialMenu/VBoxContainer/RichTextLabel
@onready var itemsList:= $PlayerPanel/Panel/MarginContainer/Submenus/ItemMenu
#@onready var playerPanel:= $PlayerPanel
@onready var scrollTimer:= $ScrollTimer

func _ready():
	playerPanel = $PlayerPanel

func setHP(value):
	hpLabel.text = str("HP: ", value, "/", player.entityInfo.hp)

func setItems(value):
	itemsList.populateItems(value)
