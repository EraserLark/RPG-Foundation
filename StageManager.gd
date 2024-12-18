extends Node
class_name StageManager

var stageUI: Stage_UI

func _ready():
	InputManager.newPlayerJoined.connect(newControllerJoined)

func newControllerJoined(joypadNum: int):
	#If this is the first controller connected
	#And if there is already an entity (empty or otherwise) created for the player
	#Swap that entity's device number for this one
	#Otherwise create new entity as normal
	
	var emptyEntity
	
	var connectedJoypads = Input.get_connected_joypads()
	
	if connectedJoypads.size() == 1:
		var entity = PlayerRoster.getPlayerByJoyNum(0)
		if entity != null:
			entity.changeDeviceNumber(joypadNum)
			return
		else:
			emptyEntity = PlayerRoster.addEmptySlot(self, joypadNum)
			var manualMenuState = ManualMenu_State.new(emptyEntity.playerStateStack, emptyEntity.input, emptyEntity.worldUI.playerPanel)
			emptyEntity.playerStateStack.addState(manualMenuState)
	else:
		emptyEntity = PlayerRoster.addEmptySlot(self, joypadNum)
		var manualMenuState = ManualMenu_State.new(emptyEntity.playerStateStack, emptyEntity.input, emptyEntity.worldUI.playerPanel)
		emptyEntity.playerStateStack.addState(manualMenuState)
