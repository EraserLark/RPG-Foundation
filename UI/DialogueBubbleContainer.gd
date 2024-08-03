extends MarginContainer

var refSpot: Node2D

func _process(delta):
	if(refSpot != null):
		var refPosition = refSpot.get_global_transform_with_canvas().origin
		set_global_position(refPosition)
