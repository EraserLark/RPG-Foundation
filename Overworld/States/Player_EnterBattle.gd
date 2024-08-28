extends State
class_name Player_EnterBattle

var battleTransitionQueue: EventQueue

var animPlayer: AnimationPlayer
var currentRoom: Room
var enemyData: Array[EnemyInfo]

func _init(sStack: StateStack):
	battleTransitionQueue = EventQueue.new(sStack)

func enter(_msg := {}):
	currentRoom = _msg["Room"]
	animPlayer = currentRoom.animPlayer
	
	if(_msg.has("EnemyData")):			#If none entered, will pass empty array
		enemyData = _msg["EnemyData"]
	
	var entryAnim = AnimationEvent.new(battleTransitionQueue, animPlayer, "EnterBattle")
	battleTransitionQueue.addEvent(entryAnim)
	
	var openBattle = OpenBattleEvent.new(battleTransitionQueue, currentRoom, enemyData)
	battleTransitionQueue.addEvent(openBattle)
	
	battleTransitionQueue.popQueue()

func resumeState():
	exit()

func exit():
	#Play anim directly here, no event. (That way players can move)
	animPlayer.play("ExitBattle")
	currentRoom.world.resumeWorld()
	super()
