extends Menu
class_name InitialMenu

@onready var itemList:= $ItemList
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
