extends Stage_UI
class_name Overworld_UI

##Preload vars
#var playerUIScene = preload("res://Overworld/UI/PlayerUI_World.tscn")

##Children References
#@onready var playerUI:= $PlayerUI
#@onready var playerMenu:= $PlayerUI/PlayerMenu
@onready var tbContainer:= $TBContainer
@onready var fadeScreen:= $Fade


##Parent references
var owManager: OverworldManager

##Non export vars
#var playerUIRoster: Array[PlayerUI_World]

func _ready():
	pass

#Runs after all nodes have finished _ready()
func initialize(sm: StageManager):
	super(sm)

func initializePlayerUI(pUI: PlayerUI, pEntity: PlayerEntity):
	super(pUI, pEntity)
	#Hide menu when first starting game
	pUI.playerPanel.visible = false

#func addPlayerUI(playerEntity: PlayerEntity):
	#var playerUI = createPlayerUI()
	#initializePlayerUI(playerUI, playerEntity)

#func createPlayerUI(playerNumber = null) -> PlayerUI:
	##Instance empty ui
	#var pUI = playerUIScene.instantiate()
	#add_child(pUI)
	#if playerNumber != null:
		#pUI.playerPanel.profileMenu.deviceNum = playerNumber
	##Add it to playerUIRoster
	#playerUIRoster.append(pUI)
	##Set color
	#pUI.playerPanel.self_modulate = PlayerRoster.rosterColors[playerNumber]
	#return pUI

#func initializePlayerUI(pUI: PlayerUI, pEntity: PlayerEntity):
	##Initialize
	#pUI.initialize(owManager, pUI.playerPanel, pEntity, playerAnchors.currentAnchorLayout)
	##Hide menu when first starting game
	#pUI.playerPanel.visible = false
	#playerUIRoster.sort_custom(sortPlayerUI)

#func adjustMenusLayout():
	#playerAnchors.determineAnchorLayout()
	#var i=0
	#for ui in playerUIRoster:
		#var rosterIndex = PlayerRoster.roster.size()-1	#Grabs most recent addition to playerRoster
		#var panelAnchorIndex = owManager.overworldUI.playerAnchors.panelAnchorPositions[i]
		#ui.currentPanelAnchor = ui.playerPanel.panelAnchors[panelAnchorIndex]
		#ui.currentStageAnchor = playerAnchors.currentAnchorLayout[i]
		#ui.centerPlayerPanel()
		#i+=1

#func showPlayerMenu(condition: bool):
	#for playerUI in playerUIRoster:
		#playerUI.playerPanel.visible = condition
#
#func removePlayerUI(pUI: PlayerUI_World):
	#playerUIRoster.erase(pUI)
	#playerUIRoster.sort_custom(sortPlayerUI)
	#pUI.queue_free()

###Used for sort_custom
#func sortPlayerUI(a, b):
	#if a.player == null or b.player==null:
		#return false
	#elif a.player.deviceNumber < b.player.deviceNumber:
		#return true
	#return false
#####
