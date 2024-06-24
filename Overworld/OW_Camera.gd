extends Camera2D

@onready var overworld = $".."
@onready var player = $"../CastList/OW_Player"
var target = null;

func _ready():
	target = player;
	get_parent().remove_child.call_deferred(self)
	target.add_child.call_deferred(self);
	#This works, but I don't like it

func _process(delta):
	pass
