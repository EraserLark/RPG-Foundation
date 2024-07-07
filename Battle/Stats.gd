extends PanelContainer

@onready var healthBar := $ProgressBar
@onready var label := $RichTextLabel

var playerUI

func changeHealth(remainingHP : int):
	healthBar.value = remainingHP
	label.text = str(remainingHP, " /10")
