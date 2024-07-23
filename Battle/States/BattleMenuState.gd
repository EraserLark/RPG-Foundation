extends State
class_name BattleMenu_State

var battleMenu

func _init(sStack : StateStack, bMenu):
	super(sStack)
	battleMenu = bMenu
	battleMenu.selectionMade.connect(exit)

func enter(_msg := {}):
	battleMenu.visible = true
	battleMenu.showActionMenu(true)

func resumeState():
	exit()

func exit():
	battleMenu.selectionMade.disconnect(exit)
	super()
