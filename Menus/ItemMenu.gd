extends Menu
class_name ItemMenu

##Prev menu vars
@onready var manualMenu:= $ManualMenu
var itemInv: Array[Item]
var playerInfo: PlayerInfo

func _ready() -> void:
	manualMenu.optionActivated.connect(itemActivated)

func initMenu(pi: PlayerInfo):
	playerInfo = pi
	manualMenu.menuManager = menuManager
	#populateMenu(playerInfo.itemList)

func OpenMenu():
	super()
	populateItems(playerInfo.itemList)
	menuManager.showSubMenu(manualMenu)

func ResumeMenu():
	menuManager.backOut()

func populateItems(newItems: Array[Item]):
	itemInv.clear()
	manualMenu.items.clear()
	
	for item in newItems:
		itemInv.append(item)
	
	for item in itemInv:
		manualMenu.items.append(item.itemName)

func grabFirstFocus():
	pass

func setPrevFocus():
	pass

func itemActivated(chosenSelection: int):
	print(str(itemInv[chosenSelection], " selected!"))
