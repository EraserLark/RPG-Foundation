extends Event
class_name Action_Phase

var battleUI
var player
var enemy

func handleInput(event : InputEvent):
	pass

func _init(eManager, e, p, bui):
	super(eManager)
	enemy = e
	player = p
	battleUI = bui

func runEvent(msg := {}):
	var playerAction = player.playerInfo.selectedAction
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
	var promptPhase = Prompt_Phase.new(eventManager, enemy, player, battleMenu)
	eventManager.addEvent(promptPhase)
	super()
