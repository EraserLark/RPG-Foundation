extends PanelContainer

@onready var itemList := $ItemList
var attackList : Array[Action]

signal attackSelected(attackNum)

func initMenu(attacks : Array[Action]):
	attackList = attacks
	
	itemList = get_node("ItemList")
	
	for attack in attackList:
		itemList.add_item(attack.eventName)

func _on_item_list_item_activated(index):
	#Whatever comes next for starting the attack. Selecting target.
	emit_signal("attackSelected", index)
