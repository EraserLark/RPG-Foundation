extends MarginContainer

var refSpot: Node2D

func _process(delta):
	var refPosition = refSpot.get_global_transform_with_canvas().origin
	set_global_position(refPosition)
