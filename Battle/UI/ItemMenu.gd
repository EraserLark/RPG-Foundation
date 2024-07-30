extends Menu

@onready var itemList:= $ItemList
var itemInv: Array[Item]

func initMenu(items: Array[Item]):
	itemInv = items
	
	for item in itemInv:
		itemList.add_item(item.itemAction.eventName)

func OpenMenu():
	super()
	itemList.grab_focus()
	itemList.select(0)

func CloseMenu():
	super()

func _on_item_list_item_activated(index):
	playerUI.itemSelected(index)
	itemList.remove_item(index)
