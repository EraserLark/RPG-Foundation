extends State
class_name BattleMenu_State

var battleMenu

func _init(sStack : StateStack, bMenu):
	super(sStack)
	battleMenu = bMenu

func enter(msg := {}):
	battleMenu.visible = true


