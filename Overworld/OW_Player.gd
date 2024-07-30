#extends OW_Actor
extends CharacterBody2D
class_name OW_Player

var owManager: OverworldManager

@export var speed := 500
@export var playerInfo : EntityInfo

@onready var animTree = $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var interactRay = $"RayCast2D"

var rayLength := 32;

func initialize(owm):
	owManager = owm
	
	var currentState = Player_Active.new(StateStack, self, owManager)
	StateStack.addState(currentState)

func interact(interactee : Object):
	if(interactee == null):
		return
	
	interactee.interactAction(self)

func addItemToInv(item : Item):
	playerInfo.itemList.append(item)
