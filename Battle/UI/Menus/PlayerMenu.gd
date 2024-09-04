extends Menu
class_name PlayerBattleMenu

##Children references
@onready var actionSelectionMenu:= $ActionMenu
@onready var attackMenu= $MarginContainer/AttackMenu
@onready var itemMenu:= $MarginContainer/ItemMenu
@onready var miscMenu:= $MarginContainer/MiscMenu
@onready var waitingMenu:= $MarginContainer/WaitingMenu

var subMenus: Array[Menu]

func _ready():
	actionSelectionMenu.optionActivated.connect(itemActivated)
	
	subMenus = [attackMenu, itemMenu, miscMenu]

func initialize(pp: PlayerPanel_Battle):
	actionSelectionMenu.menuManager = pp
	attackMenu.menuManager = pp
	itemMenu.menuManager = pp
	miscMenu.menuManager = pp
	waitingMenu.menuManager = pp
	
	#actionMenu.attackMenu = attackMenu
	#actionMenu.itemMenu = itemMenu
	#actionMenu.miscMenu = miscMenu

#func initMenu():
	#actionSelectionMenu.menuManager = menuManager

func OpenMenu():
	super()
	menuManager.showSubMenu(actionSelectionMenu)

func itemActivated(chosenSelection: int):
	#menuManager.showInitialMenuSelection(chosenSelection)
	menuManager.showSubMenu(subMenus[chosenSelection])

func ResumeMenu():
	menuManager.backOut()

func grabFirstFocus():
	pass

func setPrevFocus():
	pass
