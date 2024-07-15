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
	playerPointer.visible = true

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
