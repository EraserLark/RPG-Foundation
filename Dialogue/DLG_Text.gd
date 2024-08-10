extends Step
class_name DLG_Text

var messageSpeaker	#Want to choose from list of requiredActors in START
@export var message: Array[String]

var dialogueBox: DialogueBox

#func _init(dm: DialogueManager = null):
	#super(dm)

func runStep():
	if(dialogueBox == null):
		#var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
		var speaker = dialogueManager.performingCast["Godot Guy"]
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
