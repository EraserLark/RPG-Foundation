extends Menu
class_name InitialMenu

@onready var manualMenu:= $ManualMenu
@onready var playerView:= $VBoxContainer/CenterContainer/TextureRect
@onready var healthLabel:= $VBoxContainer/RichTextLabel

@export var menuOptions: Array[String]
var prevSelectIndex:= 0

func _ready() -> void:
	manualMenu.optionActivated.connect(itemActivated)

func initMenu():
	manualMenu.menuManager = menuManager

func OpenMenu():
	setHP()
	super()
	manualMenu.items = menuOptions
	menuManager.showSubMenu(manualMenu)

func itemActivated(chosenSelection: int):
	menuManager.showInitialMenuSelection(chosenSelection)

func setHP():
	healthLabel.text = str("HP: ", menuManager.playerInfo.hp, "/", menuManager.playerInfo.hpMax)

func ResumeMenu():
	menuManager.backOut()

func grabFirstFocus():
	pass

func setPrevFocus():
	pass
