extends ItemList
class_name ItemsList

@onready var itemList:= $MenuList
var prevSelectIndex:= 0

func grabFirstFocus():
	itemList.grab_focus()
	itemList.select(0)

func setPrevFocus():
	prevFocused = get_viewport().gui_get_focus_owner()

func grabPrevFocus():
	pass

func itemActivated(index: int):
	prevSelectIndex = index
	setPrevFocus()
	
func itemSelected():
	pass
