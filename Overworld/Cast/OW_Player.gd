#extends OW_Actor
extends CharacterBody2D
class_name OW_Player


##Child references
@onready var animTree:= $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var animPlayer:= $AnimationPlayer
@onready var interactRay:= $"RayCast2D"
@onready var danceTimer:= $DanceTimer
@onready var collisionShape:= $CollisionShape2D

##Parent references
var owManager: OverworldManager

##Export vars
@export var speed:= 500
@export var playerInfo: PlayerInfo
@export var stepCount: int
@export var encounterThreshold: int

##Non export vars
var currentDir: Vector2
var dirChangeCount:= 0
var rayLength := 32

##Initialization
func _ready():
	print("Player Ready Start")
	print("Player Ready Finish")

func initialize(om: OverworldManager, rm: Room):
	owManager = om

func getPlayerNum():
	return playerInfo.playerNumber

func setPlayerInfo(pi: PlayerInfo):
	playerInfo = pi

##Movement
func moveDirection(dir: Vector2):
	##Play walk animation?
	self.velocity = dir.normalized() * speed;
	move_and_slide()
	stepCounter()

func stepCounter():
	stepCount += 1
	if(stepCount >= encounterThreshold):
		pass

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

##Interaction
func openMenu():
	var menuState = MenuState.new(StateStack, owManager.overworldUI.playerMenu)
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
