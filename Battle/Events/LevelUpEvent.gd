extends Event
class_name LevelUp_Event

var levelUpEQ: EventQueue
var battleManager: BattleManager
var playerEntity: Entity
var playerStateStack: StateStack

func _init(player, eManager, bm):
	super(eManager)
	battleManager = bm
	playerEntity = player
	playerStateStack = playerEntity.playerStateStack
	levelUpEQ = EventQueue.new(playerStateStack)

func runEvent():
	playerEntity.entityInfo.levelUp()
	
	battleManager.cutsceneManager.play("LevelUp")
	
	var message: Array[String] = ["[rainbow]LEVEL UP![/rainbow]", str("You are now Level ", playerEntity.entityInfo.level)]
	
	playerEntity.entityUI.playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	Textbox_State.createEvent(levelUpEQ, playerStateStack, message, playerEntity.entityUI.playerPanel)
	
	levelUpEQ.popQueue()

func resumeEvent():
	if(levelUpEQ.queue.is_empty() && levelUpEQ.currentEvent == null):
		finishEvent()
	else:
		levelUpEQ.currentEvent.resumeEvent()

func finishEvent():
	super()
