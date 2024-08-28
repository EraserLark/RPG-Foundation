extends State
class_name TransitionState

var transitionEQ: EventQueue

var cutsceneManager
var world
var newRoomPath
var newRoomPort

func _init(sStack, cm, w, rp, pn):
	super(sStack)
	transitionEQ = EventQueue.new(sStack)
	cutsceneManager = cm
	world = w
	newRoomPath = rp
	newRoomPort = pn

func enter(_msg := {}):
	var fadeIn = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeIn")
	transitionEQ.addEvent(fadeIn)
	
	var changeRoom = ChangeRoomEvent.new(transitionEQ, world, newRoomPath, newRoomPort)
	transitionEQ.addEvent(changeRoom)
	
	var fadeOut = AnimationEvent.new(transitionEQ, cutsceneManager, "FadeOut")
	transitionEQ.addEvent(fadeOut)
	
	transitionEQ.popQueue()

func resumeState():
	if(transitionEQ.queue.is_empty() && transitionEQ.currentEvent == null):
		exit()
	else:
		transitionEQ.currentEvent.resumeEvent()

func exit():
	super()
