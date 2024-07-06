extends Event
class_name BM_Event

var bmState

func _init(eManager, bm):
	super(eManager) 
	var bmState = BattleMenu_State.new(StateStack, bm)

func runEvent():
	StateStack.addState(bmState)

func resumeEvent():
	finishEvent()
