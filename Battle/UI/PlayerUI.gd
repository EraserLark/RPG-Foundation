extends Control
class_name MenuSystem

#@onready var actionMenu:= $PlayerMenu/ActionMenu
#@onready var attackMenu:= $PlayerMenu/AttackMenu
#@onready var itemMenu:= $PlayerMenu/ItemMenu
#@onready var miscMenu:= $PlayerMenu/MiscMenu
#@onready var stats:= $PlayerMenu/Stats
#@onready var playerPointer:= $PlayerPointer
#@onready var playerMenu:= $PlayerMenu
#
#@onready var minigameContainer:= $PlayerMenu/SubViewportContainer
#@onready var minigameView:= $PlayerMenu/SubViewportContainer/SubViewport
#@onready var minigameZone:= $PlayerMenu/SubViewportContainer/SubViewport/MinigameZone

#var player
#var battleManager

var baseMenu: Menu
var subMenus: Array[Menu]
var menuStack: MenuStack = MenuStack.new()

var isFinished:= false

func open():
	showSubMenu(baseMenu)

func showSubMenu(menu: Menu):
	menuStack.pushMenu(menu)

func closeSubMenu():
	menuStack.popMenu()
	if(menuStack.currentMenu == null):
		isFinished = true
		StateStack.resumeCurrentState()

#func attackSelected(index: int):
	#var selectedAction = player.attackChosen(index)
	#
	#setupSelection(selectedAction)
#
#func actionSelected(index: int):
	#var selectedAction = player.actionChosen(index)
	#setupSelection(selectedAction)
#
#func itemSelected(index: int):
	#var selectedAction = player.itemChosen(index)
	#setupSelection(selectedAction)

#func setupSelection(selectedAction: Action):
	#get_viewport().set_input_as_handled() #prevents input from carrying thru
	#CloseActionMenu()
	#showActionMenu(false)
	
	#Change to event, have it enqueued in the promptEQ
	#var promptQueue = battleManager.battleState.battlePM.promptPhase.promptEQ
	#SelectionState.createEvent(promptQueue, battleManager, StateStack, playerPointer, self, selectedAction)
	##StateStack.addState(selectionState)
	#
	#promptQueue.currentEvent = promptQueue.queue[0]
	#StateStack.resumeCurrentState()

#func actionTargetSelected():
	#emit_signal("selectionMade")

#func changeStatsHealth(remaningHP: int):
	#stats.changeHealth(remaningHP)

#func showMinigame(case: bool):
	#actionMenu.visible = false
	#self.visible = case
	#playerMenu.visible = case
	#minigameContainer.visible = case

#func showPlayerMenu(case: bool):
	#self.visible = case
	#playerMenu.visible = case
	#actionMenu.visible = false
