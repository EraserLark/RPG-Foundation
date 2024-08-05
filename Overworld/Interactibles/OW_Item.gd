extends Node2D
class_name OW_Item

@onready var owManager:= $"../../.."
var item:= Item_Heal.new(null)

func interactAction(interacter : OW_Player):
	interacter.addItemToInv(item)
	var message: Array[String] = [str(item.itemName, " added to inventory")]
	var notif = Textbox_State.new(StateStack, message, owManager.ui.tbContainer)
	StateStack.addState(notif)
	queue_free()
