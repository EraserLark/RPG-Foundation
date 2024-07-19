extends State
class_name SelectionState

var playerPointer : Control
var playerUI : Control
var battleManager

var selectedAction : Action
var targetRoster : Array
var currentTarget : Entity
var currentSelection : int

func _init(sStack : StateStack, pp, plui, bm, sa):
	super(sStack)
	playerPointer = pp
	playerUI = plui
	battleManager = bm
	selectedAction = sa

func enter(_msg := {}):
	selectedAction.setupTargetOptions()
	targetRoster = selectedAction.targetOptions
	
	currentSelection = 0
	moveCursor(currentSelection)
	
	playerPointer.set_visible(true)
	print(playerPointer.is_visible_in_tree())
	print("Stall")

func handleInput(_event):
	if Input.is_action_just_pressed("ui_accept"):
		confirmSelection()
	elif Input.is_action_just_pressed("ui_left"):
		currentSelection -= 1
		currentSelection %= targetRoster.size()
		moveCursor(currentSelection)
	elif Input.is_action_just_pressed("ui_right"):
		currentSelection += 1
		currentSelection %= targetRoster.size()
		moveCursor(currentSelection)

func exit():
	playerPointer.visible = false
	playerUI.actionTargetSelected()
	super()

func moveCursor(selection : int):
	currentTarget = targetRoster[selection]
	var targetPos = currentTarget.actor.position
	
	playerPointer.moveToPosition(targetPos)

func confirmSelection():
	selectedAction.target = currentTarget
	exit()

static func createEvent(eManager, bm, ss, pp, plui, sa):
	var selectionEvent = EventClass.new(eManager, bm, ss, pp, plui, sa)
	eManager.addEvent(selectionEvent)

class EventClass:
	extends Event
	
	var battleManager
	var stateStack
	var playerPointer
	var playerUI
	var selectedAction
	
	func _init(eManager, bm, ss, pp, plui, sa):
		super(eManager)
		battleManager = bm
		stateStack = ss
		playerPointer = pp
		playerUI = plui
		selectedAction = sa
	
	func runEvent():
		var selectionSt = SelectionState.new(stateStack, playerPointer, playerUI, battleManager, selectedAction)
		StateStack.addState(selectionSt)
	
	func resumeEvent():
		finishEvent()
