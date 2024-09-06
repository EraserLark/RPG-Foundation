extends GameState
class_name Player_EnterBattle

var battleTransitionQueue: EventQueue

var animPlayer: AnimationPlayer
var currentRoom: Room
var enemyData: Array[EnemyInfo]

func _init(_msg := {}):
	battleTransitionQueue = EventQueue.new()
	super(_msg)

func enter(playerNum: int, _msg:= {}):
	PlayerRoster.roster[playerNum].enterBattleStage()

func stackEnter(_msg := {}):
	super()
	
	currentRoom = _msg["Room"]
	animPlayer = currentRoom.animPlayer
	
	if(_msg.has("EnemyData")):			#If none entered, will pass empty array
		enemyData = _msg["EnemyData"]
	
	var entryAnim = AnimationEvent.new(battleTransitionQueue, animPlayer, "EnterBattle")
	battleTransitionQueue.addEvent(entryAnim)
	
	var openBattle = OpenBattleEvent.new(battleTransitionQueue, currentRoom, enemyData)
	battleTransitionQueue.addEvent(openBattle)
	
	battleTransitionQueue.popQueue()

func stackResume():
	if battleTransitionQueue.queue.is_empty():
		stackExit()
	else:
		battleTransitionQueue.popQueue()

func stackExit():
	#Play anim directly here, no event. (That way players can move)
	animPlayer.play("ExitBattle")
	currentRoom.world.resumeWorld()
	
	for player in PlayerRoster.getActiveRoster():
		player.exitBattleStage()
	
	super()
