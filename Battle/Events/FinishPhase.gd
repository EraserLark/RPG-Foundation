extends State

@onready var battleStage := $"../.."

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	exit()

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	set_process_input(false)
	battleStage.queue_free()
