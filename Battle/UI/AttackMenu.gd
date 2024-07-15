extends Menu

@onready var itemList:= $ItemList
var attackList: Array[Action]

func initMenu(attacks: Array[Action]):
	attackList = attacks
	
	itemList = get_node("ItemList")
	
	for attack in attackList:
		itemList.add_item(attack.eventName)

func OpenMenu():
	super()
	itemList.grab_focus()
	itemList.select(0)

func CloseMenu():
	super()

func _on_item_list_item_activated(index):
	playerUI.attackSelected(index)
