extends Textbox

@onready var nameLabel = $NameLabel
@export var speakerName = ""

func _ready():
	super()		#Runs base constructor
	setName(speakerName)

func setName(name : String):
	nameLabel.text = name
