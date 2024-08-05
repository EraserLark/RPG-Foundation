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
	
	var pState = Player_Active.new(StateStack, self, owManager)
	StateStack.addState(pState)

func faceDirection(dir: Vector2):
	interactRay.target_position = dir * rayLength;
	animTree.set("parameters/Idle/blend_position", dir)
	animTree.set("parameters/Walk/blend_position", dir)

func interact(interactee : Object):
	if(interactee == null):
		return
	
	interactee.interactAction(self)

func addItemToInv(item : Item):
	var player = PlayerRoster.roster[0]
	player.itemList = Helper.append(player.itemList, item)

func endPlayer():
	StateStack.removeState()
