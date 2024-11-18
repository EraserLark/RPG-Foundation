extends PlayerUI
class_name PlayerUI_Battle

##Children references
#@onready var playerPanel:= $PlayerPanel
@onready var stats:= $PlayerPanel/Panel/Stats
@onready var playerMenu:= $PlayerPanel/Panel/PlayerMenu
@onready var selectionMenu:= $SelectionMenu
@onready var animPlayer:= $AnimationPlayer

##Outside references
var battleUI: Control

func _ready():
	playerPanel = $PlayerPanel

func initialize(stgmn: StageManager, playerPanel, playerEntity: PlayerEntity, currentAnchors: Array):
	super(stgmn, playerPanel, playerEntity, currentAnchors)
	
	selectionMenu.initialize(stageManager, self)

#func getUIDimensions() -> Vector2:
	#return Vector2(playerPanel.size.x, playerPanel.size.y)

func setHP(value):
	stats.changeHealth(value)

func setItems(value):
	playerMenu.itemMenu.populateMenu(value)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "PlayerDeath"):
		player.entityDead()
	else:
		player.emit_signal("reactionComplete")
