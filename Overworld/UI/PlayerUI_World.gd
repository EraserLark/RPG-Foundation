extends EntityUI
class_name PlayerUI_World

@onready var worldManager:= $"../../.."
@onready var hpLabel:= $PlayerMenu/MarginContainer/InitialMenu/VBoxContainer/RichTextLabel
@onready var itemsList:= $PlayerMenu/MarginContainer/Submenus/ItemMenu

func setHP(value):
	hpLabel.text = str("HP: ", value, "/", worldManager.player.playerInfo.hp)

func setItems(value):
	itemsList.populateMenu(value)