extends Menu

@onready var itemList:= $ItemList
var miscList: Array[Action]

func initMenu(actions: Array[Action]):
	miscList = actions
	
	for action in miscList:
		itemList.add_item(action.eventName)

func grabFirstFocus():
	itemList.grab_focus()
	itemList.select(0)

func _on_item_list_item_activated(index):
	menuManager.actionSelected(index)
