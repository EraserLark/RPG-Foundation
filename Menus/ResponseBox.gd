extends PanelContainer

@onready var cursor:= $Cursor
@onready var optionsList:= $MarginContainer/OptionsList

var optionsArray: Array[String]
var selectedOption: int

func _ready():
	selectedOption = 0
	moveCursor(selectedOption)
	grab_focus()

func _on_gui_input(event):
	if(event.is_action_pressed("ui_accept")):
		confirmSelection()
	elif(event.is_action_pressed("ui_up")):
		selectedOption += 1
		selectedOption %= optionsArray.size()
		moveCursor(selectedOption)
	elif(event.is_action_pressed("ui_down")):
		selectedOption -= 1
		selectedOption %= optionsArray.size()
		moveCursor(selectedOption)
	
	print(event)

func moveCursor(optionNum: int):
	cursor.reparent(optionsList.get_child(optionNum).cursorZone)
	#cursor.global_position = optionsList.get_child(optionNum).position

func confirmSelection():
	pass
