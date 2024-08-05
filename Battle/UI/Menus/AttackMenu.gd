extends Menu
class_name AttackMenu_Battle

@onready var itemList:= $ItemList
var attackList: Array[Action]

func initMenu(attacks: Array[Action]):
	attackList = attacks
	
	for attack in attackList:
		itemList.add_item(attack.eventName)

func grabFirstFocus():
	itemList.grab_focus()
	itemList.select(0)

func _on_item_list_item_activated(index):
	menuManager.attackSelected(index)
