extends MenuSystem
class_name PlayerUI_OW

@onready var initialMenu:= $MarginContainer/InitialMenu
@onready var menuList:= $MarginContainer/InitialMenu/ItemList

var menus: Array
var openMenu: Control
var prevFocused: Control

func _ready():
	menus = self.get_children()
	baseMenu = initialMenu

func open():
	self.visible = true
	super()

#func checkIfClose():
	#if(initialMenu.visible == true):
		#return true
	#else:
		#return false

func _on_menu_list_item_activated(menuNum):
	showSubMenu(menus[menuNum])
	#openMenu = menus[menuNum]
	#prevFocused = get_viewport().gui_get_focus_owner()
	#initialMenu.visible = false
	#OpenMenu()

func closeMenuSystem():
	self.visible = false
	super()

#func OpenMenu():
	#openMenu.visible = true
	#var itemList = openMenu.get_child(0)
	#itemList.grab_focus()
	#itemList.select(0)
#
#func CloseMenu():
	#if(initialMenu.visible == true):
		##exit
		#pass
	#else:
		#openMenu.visible = false
		#openMenu = null
		#prevFocused.grab_focus()
