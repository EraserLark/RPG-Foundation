extends State

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	owner.animState.travel("Idle")

func update(delta : float):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	pass
