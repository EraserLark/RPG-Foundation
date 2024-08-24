extends Control

##Preload vars
var playerUIScene = preload("res://Overworld/UI/PlayerUI_World.tscn")

##Children References
#@onready var playerUI:= $PlayerUI
#@onready var playerMenu:= $PlayerUI/PlayerMenu
@onready var tbContainer:= $TBContainer
@onready var fadeScreen:= $Fade
@onready var playerAnchors:= $PlayerAnchors

##Parent references
var owManager: OverworldManager

##Non export vars
var playerUIRoster: Array[PlayerUI_World]

func _ready():
	pass
	##Instance a player menu for each player in the PlayerRoster. Child of self.
	#var pUI = playerUIScene.instantiate()
	#add_child(pUI)
	##Add it to playerUIRoster
	#playerUIRoster.append(pUI)

#Runs after all nodes have finished _ready()
func initialize(om: OverworldManager):
	owManager = om
	#playerUI.initialize(om)
	#playerMenu.initialize(om)
	
	#Instance a player menu for each player in the PlayerRoster. Child of self.
	var i:= 0
	for entity in owManager.playerEntities:
		#Instance ui
		var pUI = playerUIScene.instantiate()
		add_child(pUI)
		#Initialize
		pUI.initialize(owManager, pUI.playerPanel, i, playerAnchors.currentAnchorLayout)
		#Add it to playerUIRoster
		playerUIRoster.append(pUI)
		i+=1

func showPlayerMenu(condition: bool):
	for playerUI in playerUIRoster:
		playerUI.playerPanel.visible = condition
