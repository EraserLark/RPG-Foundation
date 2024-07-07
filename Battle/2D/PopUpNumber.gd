extends Node2D

var label
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()

func _on_timer_timeout():
	self.queue_free()

func setLabel(amt : int):
	label = get_node("Label")
	label.text = str(amt)
