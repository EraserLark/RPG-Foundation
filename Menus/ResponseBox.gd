extends NinePatchRect

@onready var cursor:= $Cursor
@onready var optionsList:= $MarginContainer/OptionsList

var optionsArray: Array[String]
var selectedOption: int

func openMenu():
	selectedOption = 0

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

func moveCursor(optionNum: int):
	cursor.global_position = optionsList.get_child(optionNum).position

func confirmSelection():
	pass
