extends Event
class_name OpenBattleEvent

var currentRoom: Room
var enemyData: Array[EnemyInfo]

func _init(eManager: EventQueue, rm: Room, ed: Array[EnemyInfo] = []):
	super(eManager)
	currentRoom = rm
	enemyData = ed

func runEvent():
	currentRoom.startBattle(enemyData)

func resumeEvent():
	finishEvent()

func finishEvent():
	super()
