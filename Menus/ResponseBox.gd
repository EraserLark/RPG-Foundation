extends PanelContainer

var responseScenePath = "res://Menus/response.tscn"

@onready var cursor:= $Cursor
@onready var optionsList:= $MarginContainer/OptionsList

@export var optionsArray: Array[String]
@export var maxPanelWidth: int
var selectedOption: int

signal responseSelected(responseNum)

func initMenu(responseOptions: Array[String]):
	setResponses(responseOptions)
	
	selectedOption = 0
	moveCursor(selectedOption)
	self.grab_focus()

func setResponses(responses: Array[String]):
	optionsArray = responses
	if(optionsArray.size() <= 0):
		printerr("Menu has no options")
	
	#Set new response options
	for option in optionsArray:
		var response = load(responseScenePath)
		var inst = response.instantiate()
		optionsList.add_child(inst)
		inst.setLabel(option)

func _on_gui_input(event):
	if(event.is_action_pressed("ui_accept")):
		confirmSelection(selectedOption)
	elif(event.is_action_pressed("ui_up")):
		selectedOption -= 1
		selectedOption %= optionsArray.size()
		moveCursor(selectedOption)
	elif(event.is_action_pressed("ui_down")):
		selectedOption += 1
		selectedOption %= optionsArray.size()
		moveCursor(selectedOption)

func moveCursor(optionNum: int):
	var responseParent = optionsList.get_child(optionNum).cursorZone
	cursor.reparent(responseParent)
	cursor.owner = responseParent
	#cursor.global_position = optionsList.get_child(optionNum).position

func confirmSelection(selectionNum: int):
	emit_signal("responseSelected", selectionNum)
