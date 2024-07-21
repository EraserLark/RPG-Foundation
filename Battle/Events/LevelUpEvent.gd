extends Event
class_name LevelUp_Event

var levelUpEQ = EventQueue.new()
var battleManager : BattleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm

func runEvent():
	battleManager.playerEntities[0].localInfo.levelUp()
	
	battleManager.cutsceneManager.play("LevelUp")
	
	var message = str("[rainbow]LEVEL UP![/rainbow] You are now Level ", battleManager.playerEntities[0].localInfo.level)
	var textbox = battleManager.battleUI.textbox
	
	Textbox_State.createEvent(levelUpEQ, StateStack, textbox, message)
	
	levelUpEQ.popQueue()

func resumeEvent():
	if(levelUpEQ.queue.is_empty() && levelUpEQ.currentEvent == null):
		finishEvent()
	else:
		levelUpEQ.currentEvent.resumeEvent()

func finishEvent():
	super()