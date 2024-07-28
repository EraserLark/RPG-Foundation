extends CharacterBody2D
class_name OW_Actor

signal send_message(name:String, message:String)

func interactAction(interacter : OW_Player):
	var message = "Don't talk to that snowman next to me. That guy is [shake]PISSED[/shake]"
	speak(message)

func speak(message : String):
	emit_signal("send_message", name, message)
