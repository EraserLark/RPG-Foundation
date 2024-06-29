extends PanelContainer

@onready var itemList := $ItemList
var attackDict : Dictionary

signal attackSelected(attackNum)

func initMenu(attacks : Dictionary):
	attackDict = attacks
	
	itemList = get_node("ItemList")
	
	for key in attackDict:
		var attack = attackDict[key]
		itemList.add_item(attack.actionName)

func _on_item_list_item_activated(index):
	#Whatever comes next for starting the attack. Selecting target.
	emit_signal("attackSelected", index)
