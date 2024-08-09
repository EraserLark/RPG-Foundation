extends Step
class_name DLG_Text

@export var message: Array[String]

#func _init(dm: DialogueManager = null):
	#super(dm)

func runStep():
	#print("This is a text step")
	#nextStep(self)
	#Create Textbox state with all the info you need
	#May need to tweak this so that you don't have to create a textbox state for
	#the textboxes...
	var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
	var bubbleSpot = speaker.createDBC()
	var dbState = DialogueBox_State.new(StateStack, message, speaker.name, bubbleSpot)
	StateStack.addState(dbState)

func resumeStep():
	nextStep(self)
