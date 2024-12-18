extends State

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	owner.animState.travel("Idle")

func update(_delta: float, deviceNum: int):
	pass

func physicsUpdate(delta : float):
	pass

func exit():
	pass
