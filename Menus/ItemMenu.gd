extends Menu
class_name ItemMenu

@onready var itemList:= $ItemList
#var itemInv: Array[Item]
var playerInfo: PlayerInfo

func initMenu(pi: PlayerInfo):
	playerInfo = pi
	populateMenu(playerInfo.itemList)

func OpenMenu():
	populateMenu(playerInfo.itemList)
	super()

func grabFirstFocus():
	itemList.grab_focus()
	itemList.select(0)

func _on_item_list_item_activated(index):
	menuManager.itemSelected(index)

func populateMenu(items: Array[Item]):
	itemList.clear()
	
	#itemInv = items
	
	for item in items:
		itemList.add_item(item.itemAction.eventName)
