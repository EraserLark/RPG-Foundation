extends Node
class_name StageManager

var stageUI: Stage_UI

func _ready():
	InputManager.newPlayerJoined.connect(newControllerJoined)

func newControllerJoined(joypadNum: int):
	var emptyEntity = PlayerRoster.addEmptySlot(self, joypadNum)
	
	var manualMenuState = ManualMenu_State.new(emptyEntity.playerStateStack, emptyEntity.input, emptyEntity.worldUI.playerPanel)
	emptyEntity.playerStateStack.addState(manualMenuState)
