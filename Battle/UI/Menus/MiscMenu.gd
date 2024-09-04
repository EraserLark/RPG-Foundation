extends Menu

@onready var manualMenu:= $ManualMenu
var playerEntity: PlayerEntity
var miscList: Array[Action]

func _ready() -> void:
	manualMenu.optionActivated.connect(itemActivated)

func initMenu(playerEntity: PlayerEntity):
	miscList = playerEntity.entityInfo.miscList
	manualMenu.menuManager = menuManager
	
	populateItems(miscList)

func OpenMenu():
	super()
	miscList = playerEntity.entityInfo.miscList
	populateItems(miscList)
	menuManager.showSubMenu(manualMenu)

func populateItems(newItems: Array[Action]):
	miscList.clear()
	manualMenu.items.clear()
	
	for action in newItems:
		manualMenu.items.append(action.name)

func itemActivated(chosenSelection: int):
	menuManager.actionSelected(chosenSelection)
	
func grabFirstFocus():
	pass

func setPrevFocus():
	pass

func ResumeMenu():
	menuManager.backOut()
