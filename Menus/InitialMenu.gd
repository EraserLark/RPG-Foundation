extends Menu
class_name InitialMenu

@onready var menuList:= $MenuList
@onready var playerView:= $VBoxContainer/CenterContainer/TextureRect
@onready var healthLabel:= $VBoxContainer/RichTextLabel
var prevSelectIndex:= 0

func OpenMenu():
	setHP()
	super()

func grabFirstFocus():
	menuList.grab_focus()
	menuList.select(0)

func setPrevFocus():
	prevFocused = get_viewport().gui_get_focus_owner()

func grabPrevFocus():
	pass

func itemActivated(index: int):
	prevSelectIndex = index
	setPrevFocus()

func setHP():
	healthLabel.text = str("HP: ", menuManager.playerInfo.hp, "/", menuManager.playerInfo.hpMax)
