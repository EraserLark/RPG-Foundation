extends Node2D
class_name OW_Item

var item = Item_Heal.new()

func interactAction(interacter : OW_Player):
	interacter.addItemToInv(item)
	queue_free()
