extends Textbox
class_name DialogueBox

static var DBscenePath = "res://UI/DialogueBox.tscn"

@onready var nameLabel:= $NameLabel
@export var speakerName:= ""

func _ready():
	super()
	setName(speakerName)

func setName(name: String):
	nameLabel.text = name

static func createDBInstance(parent: Node, lines: Array[String], sp: String, responseOptions: Array[String] = []) -> DialogueBox:
	var scene = load(DBscenePath)
	var inst = scene.instantiate()
	inst.lineQueue = lines.duplicate()
	inst.target = parent
	inst.speakerName = sp
	inst.responseOptions = responseOptions
	parent.add_child(inst)
	
	return inst

func showResponsePanel():
	pass
