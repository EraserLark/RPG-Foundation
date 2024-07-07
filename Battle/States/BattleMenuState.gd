extends State
class_name BattleMenu_State

var battleMenu

func _init(sStack : StateStack, bMenu):
	super(sStack)
	battleMenu = bMenu
	battleMenu.selectionMade.connect(exit)

func enter(msg := {}):
	battleMenu.showActionMenu(true)

func exit():
	battleMenu.selectionMade.disconnect(exit)
	super()
