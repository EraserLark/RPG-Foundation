#extends OW_Actor
extends CharacterBody2D
class_name OW_Player

var owManager: OverworldManager

@export var speed:= 500
@export var playerInfo: PlayerInfo

@onready var animTree:= $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var animPlayer:= $AnimationPlayer
@onready var interactRay:= $"RayCast2D"
@onready var danceTimer:= $DanceTimer
@onready var collisionShape:= $CollisionShape2D

var currentDir: Vector2
var dirChangeCount:= 0
var rayLength := 32

func getPlayerNum():
	return playerInfo.playerNumber

func initialize(owm, pi):
	owManager = owm
	playerInfo = pi

func moveDirection(dir: Vector2):
	##Play walk animation?
	self.velocity = dir.normalized() * speed;
	move_and_slide()

func faceDirection(dir: Vector2) -> bool:
	interactRay.target_position = dir * rayLength;
	animTree.set("parameters/Idle/blend_position", dir)
	animTree.set("parameters/Walk/blend_position", dir)
	#animState.travel("Idle")
	
	if(dir != currentDir):
		danceTimer.start()
		dirChangeCount += 1
	currentDir = dir
	
	if(dirChangeCount >= 10):
		var danceState = Player_Dance.new(StateStack, self)
		StateStack.addState(danceState)
		return true
	return false

func _on_dance_timer_timeout():
	dirChangeCount = 0

func danceFinish():
	StateStack.removeState()
	faceDirection(Vector2(0,1))

func openMenu():
	var menuState = MenuState.new(StateStack, owManager.ui.playerMenu)
	StateStack.addState(menuState)

func castInteractRay():
	var interactee = interactRay.get_collider()
	if(interactee is StaticBody2D):
		interactee = interactee.get_parent()
	interact(interactee)

func interact(interactee : Object):
	if(interactee == null):
		return
	
	interactee.interactAction(self)

func addItemToInv(item : Item):
	var player = PlayerRoster.roster[0]
	player.itemList = Helper.append(player.itemList, item)

func endPlayerActor():
	pass
	#StateStack.removeState()
