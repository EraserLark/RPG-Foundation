@tool
extends Step
class_name DLG_Text

var messageSpeaker	#Want to choose from list of requiredActors in START
@export var speakerName: String
enum BOX_LOCATION {SmallBubble, BigBubble, PlayerPanel, BigBox}
@export var boxLocation: BOX_LOCATION = BOX_LOCATION.SmallBubble
@export var message: Array[String]

#@export() var speakerOptions: Array[String]
var dialogueBox: Textbox

#func _init(dm: DialogueManager = null):
	#super(dm)

func runStep():
	if(dialogueBox == null):
		#var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
		match boxLocation:
			BOX_LOCATION.SmallBubble:
				var speaker = dialogueManager.performingCast[speakerName]
				var bubbleSpot = speaker.createDBC()
				dialogueBox = DialogueBox.createDBInstance(bubbleSpot, message, speaker.npcResource.npcName)
			
			BOX_LOCATION.BigBubble:
				var speaker = dialogueManager.performingCast[speakerName]
				dialogueBox = DialogueBox.createDBInstance(DialogueSystem.tbContainer_Stage, message, speaker.npcResource.npcName)
			
			BOX_LOCATION.PlayerPanel:
				DialogueSystem.tbContainer_PlayerPanel.visible = true
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_PlayerPanel.marginContainer, message)
			
			BOX_LOCATION.BigBox:
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_Stage, message)
	else:
		dialogueBox.lineQueue = message
	dialogueBox.advanceLineQueue()

func resumeStep():
	#If next step is a Text step, leave textbox open
	#Otherwise close Textbox
	var nextStep = getNextStep(self)
	if(!nextStep is DLG_Text or nextStep.boxLocation != boxLocation):
		dialogueBox.closeTextbox()
		if(boxLocation == BOX_LOCATION.PlayerPanel):
			DialogueSystem.tbContainer_PlayerPanel.visible = false
	else:
		nextStep.dialogueBox = dialogueBox
	advanceNextStep(self)

func confirmInput():
	dialogueBox.confirmInput()

func moveInput(input: Vector2):
	dialogueBox.moveInput(input)
