#extends OW_Actor
extends CharacterBody2D
class_name OW_Player

var owManager: OverworldManager

@export var speed := 500
@export var playerInfo : PlayerInfo

@onready var animTree = $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var interactRay = $"RayCast2D"
var playerState

var rayLength := 32;

func initialize(owm):
	owManager = owm
	
	playerState = Player_Active.new(StateStack, self, owManager)
	StateStack.addState(playerState)

func interact(interactee : Object):
	if(interactee == null):
		return
	
	interactee.interactAction(self)

func addItemToInv(item : Item):
	var player = PlayerRoster.roster[0]
	player.itemList = Helper.append(player.itemList, item)

func endPlayer():
	playerState = null
	StateStack.removeState()
