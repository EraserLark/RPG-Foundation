extends State

@onready var eventQueue := $"../../EventQueue"

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	eventQueue.popQueue()

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	pass
