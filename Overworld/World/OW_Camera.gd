extends Camera2D

@onready var overworld = $".."
@onready var castList = $"../CastList"
#@onready var player = $"../CastList/OW_Player"
var target = null;

func _ready():
	#target = player;
	#get_parent().remove_child.call_deferred(self)
	#target.add_child.call_deferred(self);
	pass
	#This works, but I don't like it

func setTarget(newTarget: Node2D):
	target = newTarget

func _process(delta):
	if(target):
		self.position = target.position
