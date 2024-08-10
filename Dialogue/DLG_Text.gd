extends Step
class_name DLG_Text

@export var message: Array[String]

var dialogueBox: DialogueBox

#func _init(dm: DialogueManager = null):
	#super(dm)

func runStep():
	#print("This is a text step")
	#nextStep(self)
	#Create Textbox state with all the info you need
	#May need to tweak this so that you don't have to create a textbox state for
	#the textboxes...

	#var dbState = DialogueBox_State.new(StateStack, message, speaker.name, bubbleSpot)
	#StateStack.addState(dbState)
	if(dialogueBox == null):
		var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
		var bubbleSpot = speaker.createDBC()
		dialogueBox = DialogueBox.createDBInstance(bubbleSpot, message, speaker.name)
	else:
		dialogueBox.lineQueue = message
	dialogueBox.advanceLineQueue()

func resumeStep():
	#If next step is a Text step, leave textbox open
	#Otherwise close Textbox
	var nextStep = getNextStep(self)
	if(!nextStep is DLG_Text):
		dialogueBox.closeTextbox()
	else:
		nextStep.dialogueBox = dialogueBox
	advanceNextStep(self)

func confirmInput():
	dialogueBox.advance()
