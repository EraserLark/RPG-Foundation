extends Event
class_name ChangeRoomEvent

var world

var roomPath
var passageNum

func _init(eManager: EventQueue, w, rp: String, pn: int):
	super(eManager)
	world = w
	roomPath = rp
	passageNum = pn

func runEvent():
	world.onRoomExit(roomPath, passageNum)
	finishEvent()

func finishEvent():
	super()
