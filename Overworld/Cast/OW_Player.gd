#extends OW_Actor
extends CharacterBody2D
class_name OW_Player

var owManager: OverworldManager

@export var speed := 500
@export var playerInfo : PlayerInfo

@onready var animTree = $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var interactRay = $"RayCast2D"

var rayLength := 32;

func initialize(owm):
	owManager = owm

func moveDirection(dir: Vector2):
	self.velocity = dir.normalized() * speed;
	move_and_slide()

func faceDirection(dir: Vector2):
	interactRay.target_position = dir * rayLength;
	animTree.set("parameters/Idle/blend_position", dir)
	animTree.set("parameters/Walk/blend_position", dir)

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
