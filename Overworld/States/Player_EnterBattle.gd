extends State
class_name Player_EnterBattle

var battleTransitionQueue:= EventQueue.new()

var animPlayer: AnimationPlayer
var currentRoom: Room

func enter(_msg := {}):
	currentRoom = _msg["Room"]
	animPlayer = currentRoom.animPlayer
	
	var entryAnim = AnimationEvent.new(battleTransitionQueue, animPlayer, "EnterBattle")
	battleTransitionQueue.addEvent(entryAnim)
	
	var openBattle = OpenBattleEvent.new(battleTransitionQueue, currentRoom)
	battleTransitionQueue.addEvent(openBattle)
	
	battleTransitionQueue.popQueue()

func resumeState():
	exit()

func exit():
	#Play anim directly here, no event. (That way players can move)
	animPlayer.play("ExitBattle")
	super()
