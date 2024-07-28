extends CharacterBody2D
class_name OW_Actor

signal send_message(name:String, message:String)

func interactAction(interacter : OW_Player):
	var message = "[b]I[/b] [i]think[/i] [u]I[/u] [s]had[/s] [font_size=30]some[/font_size] [b][i]bad[/i][/b] [color=yellow]tofu [bgcolor=red]earlier[/bgcolor][/color]. [wave]I'm feeling [rainbow]fruity[/rainbow].[/wave]"
	speak(message)

func speak(message : String):
	emit_signal("send_message", name, message)
