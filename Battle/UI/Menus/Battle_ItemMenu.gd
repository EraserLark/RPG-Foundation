extends ItemMenu
class_name Battle_ItemMenu

func itemActivated(chosenSelection: int):
	menuManager.itemSelected(chosenSelection)
	#print(str(itemInv[chosenSelection], " selected!"))
