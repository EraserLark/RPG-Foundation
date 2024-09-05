extends Menu
class_name AttackMenu_Battle

#@onready var itemList:= $ItemList
@onready var manualMenu:= $ManualMenu
var playerEntity: PlayerEntity
var attackList: Array[Action]

func _ready() -> void:
	manualMenu.optionActivated.connect(itemActivated)

func initMenu(playerPanel: PlayerPanel_Battle):
	menuManager = playerPanel
	self.playerEntity = menuManager.playerEntity
	attackList = playerEntity.entityInfo.attackList
	manualMenu.menuManager = menuManager
	
	populateItems(attackList)

func OpenMenu():
	super()
	attackList = playerEntity.entityInfo.attackList
	populateItems(attackList)
	menuManager.showSubMenu(manualMenu)

func populateItems(newItems: Array[Action]):
	manualMenu.items.clear()
	
	for attack in newItems:
		manualMenu.items.append(attack.eventName)

func itemActivated(chosenSelection: int):
	menuManager.attackSelected(chosenSelection)
	
func grabFirstFocus():
	pass

func setPrevFocus():
	pass

func ResumeMenu():
	menuManager.backOut()
