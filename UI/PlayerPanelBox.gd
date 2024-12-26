extends NinePatchRect

var tween

func _ready() -> void:
	centerPanel(self.position)

func centerPanel(currentPos: Vector2):
	currentPos = Vector2(-size.x / 2, -size.y / 2)
	self.position = currentPos

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_page_up"):
		var newSize = Vector2(100,100)
		if tween:
			tween.kill()
		tween = create_tween().set_parallel(true)
		tween.tween_property(self, "size", newSize, 1)
		tween.tween_method(centerPanel, self.position, -newSize/2, 1)
	elif Input.is_action_just_pressed("ui_page_down"):
		var newSize = Vector2(600,10)
		if tween:
			tween.kill()
		tween = create_tween().set_parallel(true)
		tween.tween_property(self, "size", newSize, 1)
		tween.tween_method(centerPanel, self.position, -newSize/2, 1)
