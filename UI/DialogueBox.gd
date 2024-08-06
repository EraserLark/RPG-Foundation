extends Textbox
class_name DialogueBox

static var DBscenePath = "res://UI/DialogueBox.tscn"

@onready var nameLabel:= $NameLabel
@export var speakerName:= ""
#@export var speakerMessage:= ""
#
#@onready var castList:= get_node("../../../World/CastList")

func _ready():
	super()
	setName(speakerName)
	#castList.actor_speaking.connect(openDialogue)

static func createDBInstance(parent: Node, lines: Array[String], sp: String) -> DialogueBox:
	var scene = load(DBscenePath)
	var inst = scene.instantiate()
	parent.add_child(inst)
	
	inst.lineQueue = lines.duplicate()
	inst.target = parent
	inst.speakerName = sp
	#inst.customSize = dimensions
	#inst.customPosition = screenPos
	inst.positionBox()
	
	return inst

#func openDialogue(name, message):
	#speakerName = name
	#speakerMessage = message
	#var dbState = DB_State.new(StateStack, self)
	#StateStack.addState(dbState)

#func newDialogue():
	#currentLine = speakerMessage
	#setName(speakerName)
	#typeText(currentLine)

func positionBox():
	pass

func setName(name: String):
	nameLabel.text = name
