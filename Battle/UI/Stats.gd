extends PanelContainer

@onready var healthBar:= $ProgressBar
@onready var label:= $RichTextLabel

var maxHealth: int

func setInitialHealth(playerInfo: PlayerInfo):
	maxHealth = playerInfo.hpMax
	healthBar.max_value = maxHealth
	healthBar.value = playerInfo.hp
	label.text = str(playerInfo.hp, " /", maxHealth)

func changeHealth(remainingHP: int):
	healthBar.value = remainingHP
	label.text = str(remainingHP, " /", maxHealth)
	
	var color
	var val
	
	if(healthBar.value >= healthBar.max_value / 2):
		val = absf(((healthBar.value - healthBar.max_value / 2) / (healthBar.max_value - healthBar.max_value / 2)) - 1)
		color = Color(val,1,0)
	else:
		val = 1 * (healthBar.value / (healthBar.max_value/2))
		color = Color(1,val,0)
	
	healthBar.set_self_modulate(color)
