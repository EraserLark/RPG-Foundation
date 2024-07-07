extends Menu

@onready var itemList := $ItemList

func OpenMenu():
	super()
	get_viewport().gui_get_focus_owner()
	itemList.grab_focus()
	itemList.select(0)

func _on_item_list_item_activated(index):
	playerUI.itemSelected(index)
