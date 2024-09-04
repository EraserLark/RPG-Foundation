extends GameState
class_name GameMenuState

#var menuSystem: MenuSystem
#var playerInput: DeviceInput
#
#func _init():
	#pass
#
#func enter(_msg:= {}):
	#menuSystem.open(stateStack)
#
#func resumeState():
	#if(menuSystem.isFinished):
		#exit()
	#else:
		#menuSystem.resumeSubMenu()
#
###For directional input
#func update(delta):
	#menuSystem.menuStack.currentMenu.runMenuUpdate(playerInput)
#
###For button presses
#func handleInput(_event: InputEvent):
	#if _event.device != playerInput.device:
		#return
	#
	#menuSystem.menuStack.currentMenu.buttonPressed(_event)
#
#func exit():
	#super()
