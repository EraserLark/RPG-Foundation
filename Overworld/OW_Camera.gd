extends Camera2D

@onready var overworld = $".."
var target = null;

func _ready():
	target = overworld.get_child(0);
	get_parent().remove_child.call_deferred(self)
	target.add_child.call_deferred(self);
	#This works, but I don't like it

func _process(delta):
	pass
