extends GameState
class_name TransitionState

var transitionEQ: EventQueue

var cutsceneManager
var world
var newRoomPath
var newRoomPort

func _init(cm, w, rp, pn):
	transitionEQ = EventQueue.new()
	cutsceneManager = cm
	world = w
	newRoomPath = rp
	newRoomPort = pn
	super()

func stackEnter():
	var fadeIn = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeIn")
	transitionEQ.addEvent(fadeIn)
	
	var changeRoom = ChangeRoomEvent.new(transitionEQ, world, newRoomPath, newRoomPort)
	transitionEQ.addEvent(changeRoom)
	
	var fadeOut = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeOut")
	transitionEQ.addEvent(fadeOut)
	
	transitionEQ.popQueue()

func enter(playerNum: int, _msg := {}):
	pass
	#var fadeIn = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeIn")
	#transitionEQ.addEvent(fadeIn)
	#
	#var changeRoom = ChangeRoomEvent.new(transitionEQ, world, newRoomPath, newRoomPort)
	#transitionEQ.addEvent(changeRoom)
	#
	#var fadeOut = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeOut")
	#transitionEQ.addEvent(fadeOut)
	#
	#transitionEQ.popQueue()

func stackResume():
	if(transitionEQ.queue.is_empty() && transitionEQ.currentEvent == null):
		stackExit()
	else:
		transitionEQ.currentEvent.resumeEvent()

func stackExit():
	super()
