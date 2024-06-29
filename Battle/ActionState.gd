extends State

@onready var eventQueue := $"../../EventQueue"

@onready var battleUI = $"../../CanvasLayer/BattleUI"
@onready var player = $"../../BA_Player"
@onready var enemy = $"../../BattleStage/BA_Enemy"

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	var enemyAction = Attack.new(eventQueue, "Enemy Attack", enemy.enemyInfo, player.playerInfo, 2, 0)
	var resultsMessage : String = str("Player health: ", player.playerInfo.hp, "\nEnemy health: ", enemy.enemyInfo.hp)
	var results = TB_Action.new(eventQueue, battleUI, resultsMessage)
	
	eventQueue.queue.append(enemyAction)
	eventQueue.queue.append(results)
	
	eventQueue.popQueue()

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	pass
