extends Node2D
class_name OW_Item

@onready var owManager:= $"../../.."
var item:= Item_Heal.new()

func interactAction(interacter : OW_Player):
	interacter.addItemToInv(item)
	var message: Array[String] = [str(item.itemName, " added to inventory")]
	var notif = Textbox_State.new(interacter.playerEntity.playerStateStack, message, owManager.ui.tbContainer)
	interacter.playerEntity.playerStateStack.addState(notif)
	queue_free()
