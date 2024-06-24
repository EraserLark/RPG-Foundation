extends Textbox

@onready var nameLabel := $NameLabel
@export var speakerName := ""

@onready var castList := get_node("../../../World/CastList")

func _ready():
	super()		#Runs base constructor
	castList.actor_speaking.connect(newDialogue)

func newDialogue(name, message):
	setName(name)
	typeText(message)

func setName(name : String):
	nameLabel.text = name
