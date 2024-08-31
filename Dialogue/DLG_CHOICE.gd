@tool
extends DLG_Text
class_name DLG_Choice

@export var choiceOptions: Array[String]: set = setChoiceOptions
var selectedChoice: int

func setChoiceOptions(options: Array[String]):
	choiceOptions = options
	if self.get_child_count() < choiceOptions.size():
		printerr("Not all options have a route!")

func runStep():
	if(dialogueBox == null):
		#var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
		match boxLocation:
			BOX_LOCATION.SmallBubble:
				var speaker = dialogueManager.performingCast[speakerName]
				var bubbleSpot = speaker.createDBC()
				dialogueBox = DialogueBox.createDBInstance(bubbleSpot, message, speaker.npcResource.npcName, dialogueManager.dialogueState, choiceOptions)
			
			BOX_LOCATION.BigBubble:
				var speaker = dialogueManager.performingCast[speakerName]
				dialogueBox = DialogueBox.createDBInstance(DialogueSystem.tbContainer_Stage, message, speaker.npcResource.npcName, dialogueManager.dialogueState, choiceOptions)
			
			BOX_LOCATION.PlayerPanel:
				DialogueSystem.tbContainer_PlayerPanel.visible = true
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_PlayerPanel.marginContainer, message, dialogueManager.dialogueState, choiceOptions)
			
			BOX_LOCATION.BigBox:
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_Stage, message, dialogueManager.dialogueState, choiceOptions)
	else:
		dialogueBox.lineQueue = message
		dialogueBox.responseOptions = choiceOptions
	
	dialogueBox.responseChosen.connect(setResponse)
	dialogueBox.advanceLineQueue()

func resumeStep():
	#If next step is a Text step, leave textbox open
	#Otherwise close Textbox
	var nextStep = get_child(selectedChoice).get_child(0)
	if(!nextStep is DLG_Text or nextStep.boxLocation != boxLocation):
		dialogueBox.closeTextbox()
		if(boxLocation == BOX_LOCATION.PlayerPanel):
			DialogueSystem.tbContainer_PlayerPanel.visible = false
	else:
		nextStep.dialogueBox = dialogueBox
	
	dialogueBox.responseChosen.disconnect(setResponse)
	dialogueManager.jumpTo(nextStep)

func setResponse(value: int):
	selectedChoice = value

func confirmInput():
	dialogueBox.confirmInput()

func moveInput(input: Vector2):
	dialogueBox.moveInput(input)
