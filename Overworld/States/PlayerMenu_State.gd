extends State
class_name PlayerMenu_State

var ui
var playerMenu

func _init(sStack : StateStack, userintf):
	super(sStack)
	ui = userintf
	playerMenu = ui.playerMenu

func enter(_msg := {}):
	ui.showPlayerMenu(true)
	var focus = playerMenu.get_node("InitialMenu").get_node("MenuList")
	focus.grab_focus()
	focus.select(0)

func update(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		playerMenu.CloseMenu()

func resumeState():
	pass

func exit():
	ui.showPlayerMenu(false)
	super()
