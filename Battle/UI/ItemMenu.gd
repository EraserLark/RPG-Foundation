extends Menu

@onready var itemList:= $ItemList
var itemInv: Array[Item]

func initMenu(items: Array[Item]):
	populateMenu(items)

func grabFirstFocus():
	itemList.grab_focus()
	itemList.select(0)

func _on_item_list_item_activated(index):
	menuManager.itemSelected(index)
	#itemList.remove_item(index)

func populateMenu(items: Array[Item]):
	itemList.clear()
	
	itemInv = items
	
	for item in itemInv:
		itemList.add_item(item.itemAction.eventName)
