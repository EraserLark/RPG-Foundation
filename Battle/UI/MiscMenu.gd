extends Menu

@onready var itemList := $ItemList
var miscList : Array[Action]

func initMenu(actions : Array[Action]):
	miscList = actions
	
	itemList = get_node("ItemList")
	
	for action in miscList:
		itemList.add_item(action.eventName)

func OpenMenu():
	super()
	itemList.grab_focus()
	itemList.select(0)

func CloseMenu():
	super()

func _on_item_list_item_activated(index):
	playerUI.actionSelected(index)
