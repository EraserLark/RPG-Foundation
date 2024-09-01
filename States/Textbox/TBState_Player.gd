extends Textbox_State
class_name Player_TextboxState

var deviceNumber: int

func _init(sStack, m, cntnr, dn: int):
	super(sStack, m, cntnr)
	deviceNumber = dn

func handleInput(_event: InputEvent):
	if _event.device != deviceNumber:
		return
	
	
