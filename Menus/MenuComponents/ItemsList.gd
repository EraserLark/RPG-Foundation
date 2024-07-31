extends ItemList

var manager: Menu

func _ready():
	manager = get_parent()

func _on_item_activated(index):
	manager.itemActivated()

func _on_item_selected(index):
	manager.itemSelected()
