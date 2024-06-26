extends OW_Actor

@export var speed := 500;

@onready var animTree = $"AnimationTree"
@onready var animState = animTree.get("parameters/playback")
@onready var interactRay = $"RayCast2D"

var rayLength := 72;

func _ready():
	StateMachineStack.addSM($StateManager)
