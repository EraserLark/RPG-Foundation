extends Event
class_name Action_Phase

var battleUI
var player
var enemy

func _init(eManager, e, p, bui):
	super(eManager)
	enemy = e
	player = p
	battleUI = bui
	
	eManager.queueEmpty.connect(finishEvent)

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
	playerAction.eventManager = self.eventManager
	var enemyAction = Attack.new(eventManager, "Enemy Attack", enemy.enemyInfo, player.playerInfo, 2, 0)
	
	eventManager.queue.append(playerAction)
	eventManager.queue.append(enemyAction)
	eventManager.popQueue()

func resumeEvent():
	if(eventManager.queue.front() == eventManager.currentEvent):
		finishEvent()
	else:
		eventManager.currentEvent.resumeEvent()

func finishEvent():
	var battleMenu = battleUI.get_node("BattleMenu")
	var promptPhase = Prompt_Phase.new(eventManager, enemy, player, battleUI)
	eventManager.addEvent(promptPhase)
	eventManager.queueEmpty.disconnect(finishEvent)
	super()
