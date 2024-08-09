extends State
class_name DialogueState

var dialogueManager: DialogueManager

func _init(sStack : StateStack, dm: DialogueManager):
	super(sStack)
	dialogueManager = dm

func handleInput(_event : InputEvent):
	pass

func enter(_msg := {}):
	pass

func update(_delta : float):
	pass

func physicsUpdate(_delta : float):
	pass

func resumeState():
	exit()

func exit():
	super()
