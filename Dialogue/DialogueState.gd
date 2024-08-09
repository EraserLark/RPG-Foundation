extends State
class_name DialogueState

func _init(sStack : StateStack):
	super(sStack)

func handleInput(_event : InputEvent):
	pass

func enter(_msg := {}):
	pass

func update(_delta : float):
	pass

func physicsUpdate(_delta : float):
	pass

func resumeState():
	pass

func exit():
	super()
