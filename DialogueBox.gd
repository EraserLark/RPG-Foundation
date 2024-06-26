extends Textbox

@onready var nameLabel := $NameLabel
@export var speakerName := ""
@export var speakerMessage := ""

@onready var castList := get_node("../../../World/CastList")

func _ready():
	super()		#Runs base constructor
	castList.actor_speaking.connect(openDialogue)

func openDialogue(name, message):
	speakerName = name
	speakerMessage = message
	StateMachineStack.addSM($StateMachine)

func newDialogue():
	line = speakerMessage
	setName(speakerName)
	typeText()

func setName(name : String):
	nameLabel.text = name
