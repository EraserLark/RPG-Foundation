extends Event
class_name Action_Phase

var battleUI
var player
var enemy
var battleManager

func _init(eManager, bm):
	super(eManager)
	battleManager = bm
	enemy = bm.enemyEntity
	player = bm.playerEntity
	battleUI = bm.battleUI
	
	eManager.queueEmpty.connect(finishEvent)

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.eventManager
	playerAction.target = enemy
	var enemyAction = Attack.new(eventManager, "Enemy Attack", enemy, player, 2, 0)
	
	eventManager.queue.append(playerAction)
	eventManager.queue.append(enemyAction)
	eventManager.popQueue()

func resumeEvent():
	if(eventManager.queue.front() == eventManager.currentEvent):
		finishEvent()
	else:
		eventManager.currentEvent.resumeEvent()

func finishEvent():
	var promptPhase = Prompt_Phase.new(eventManager, battleManager)
	eventManager.addEvent(promptPhase)
	eventManager.queueEmpty.disconnect(finishEvent)
	super()
