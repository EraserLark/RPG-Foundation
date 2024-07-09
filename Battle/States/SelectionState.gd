extends State
class_name SelectionState

var playerPointer : Control
var playerUI : Control
var battleManager

var enemies : Array[EnemyEntity]
var currentEnemy : EnemyEntity
var currentSelection : int

func _init(sStack : StateStack, pp, plui, bm):
	super(sStack)
	playerPointer = pp
	playerUI = plui
	battleManager = bm
	enemies = battleManager.battleRoster.enemies

func enter(msg := {}):
	currentSelection = 0
	moveCursor(currentSelection)
	playerPointer.visible = true

func handleInput(event):
	if Input.is_action_just_pressed("ui_accept"):
		confirmSelection()
	elif Input.is_action_just_pressed("ui_left"):
		currentSelection -= 1
		currentSelection %= enemies.size()
		moveCursor(currentSelection)
	elif Input.is_action_just_pressed("ui_right"):
		currentSelection += 1
		currentSelection %= enemies.size()
		moveCursor(currentSelection)

func exit():
	playerPointer.visible = false
	playerUI.attackTargetSelected()
	super()

func moveCursor(selection : int):
	currentEnemy = enemies[selection]
	var enemyPos = currentEnemy.enemyActor.position
	
	playerPointer.moveToPosition(enemyPos)

func confirmSelection():
	battleManager.playerEntity.localPlayer.selectedAction.target = currentEnemy
	exit()
