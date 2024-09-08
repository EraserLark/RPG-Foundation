@tool
extends Step
class_name DLG_Text

var messageSpeaker: String:
	get:
		return messageSpeaker
	set(value):
		messageSpeaker = value
var speakerName: String
enum BOX_LOCATION {SmallBubble, BigBubble, PlayerPanel, BigBox}
@export var boxLocation: BOX_LOCATION = BOX_LOCATION.SmallBubble
@export var message: Array[String]

var dialogueBox: Textbox

func _get_property_list() -> Array:
	var properties = []
	
	properties.append({
		"name": "messageSpeaker",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(availableActors)
	})
	
	print(str("Text step available actors: ", availableActors))
	
	return properties

func runStep():
	if(dialogueBox == null):
		#var speaker = DialogueSystem.world.currentRoom.castList.get_node("OW_NPC")
		var speaker = dialogueManager.performingCast[messageSpeaker]
		match boxLocation:
			BOX_LOCATION.SmallBubble:
				var bubbleSpot = speaker.createDBC()
				dialogueBox = DialogueBox.createDBInstance(bubbleSpot, message, speaker.npcResource.npcName, dialogueManager.dialogueState)
			
			BOX_LOCATION.BigBubble:
				dialogueBox = DialogueBox.createDBInstance(DialogueSystem.tbContainer_Stage, message, speaker.npcResource.npcName, dialogueManager.dialogueState)
			
			BOX_LOCATION.PlayerPanel:
				DialogueSystem.tbContainer_PlayerPanel.visible = true
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_PlayerPanel.marginContainer, message, dialogueManager.dialogueState)
			
			BOX_LOCATION.BigBox:
				dialogueBox = Textbox.createInstance(DialogueSystem.tbContainer_Stage, message, dialogueManager.dialogueState)
	else:
		dialogueBox.lineQueue = message.duplicate()
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
