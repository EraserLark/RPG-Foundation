extends Control
class_name Stage_UI

@export var playerUIScene: PackedScene
@onready var playerAnchors:= $PlayerAnchors
var playerUIRoster: Array[PlayerUI]
var stageManager: StageManager

func initialize(sm: StageManager):
	stageManager = sm
	
	#Instance a player menu for each player in the PlayerRoster. Child of self.
	var i:= 0
	for entity in PlayerRoster.getActiveRoster():
		addPlayerUI(entity)
		i+=1
		
func addPlayerUI(playerEntity: PlayerEntity):
	var playerUI = createPlayerUI(playerEntity.deviceNumber)
	initializePlayerUI(playerUI, playerEntity)

func createPlayerUI(playerNumber = null) -> PlayerUI:
	#Instance empty ui
	var pUI = playerUIScene.instantiate()
	add_child(pUI)
	if playerNumber != null:
		pUI.playerPanel.profileMenu.deviceNum = playerNumber
	#Add it to playerUIRoster
	playerUIRoster.append(pUI)
	#Adjust UI layout
	stageManager.stageUI.adjustMenusLayout()
	return pUI

func initializePlayerUI(pUI: PlayerUI, pEntity: PlayerEntity):
	#Initialize
	pUI.initialize(stageManager, pUI.playerPanel, pEntity, playerAnchors.currentAnchorLayout)
	playerUIRoster.sort_custom(sortPlayerUI)

func adjustMenusLayout():
	playerAnchors.determineAnchorLayout()
	var i=0
	for ui in playerUIRoster:
		var rosterIndex = PlayerRoster.roster.size()-1	#Grabs most recent addition to playerRoster
		var panelAnchorIndex = stageManager.stageUI.playerAnchors.panelAnchorPositions[i]
		ui.currentPanelAnchor = ui.playerPanel.panelAnchors[panelAnchorIndex]
		ui.currentStageAnchor = playerAnchors.currentAnchorLayout[i]
		ui.centerPlayerPanel()
		
		if self is Battle_UI:
			ui.playerPanel.flipHealthbar(playerAnchors.panelAttachmentsFlip[i][0])
			ui.playerPanel.flipActionButtons(playerAnchors.panelAttachmentsFlip[i][1])
		
		i+=1

func showPlayerMenu(condition: bool):
	for playerUI in playerUIRoster:
		playerUI.playerPanel.visible = condition

func removePlayerUI(pUI: PlayerUI):
	playerUIRoster.erase(pUI)
	playerUIRoster.sort_custom(sortPlayerUI)
	pUI.queue_free()

##Used for sort_custom
func sortPlayerUI(a, b):
	if a.player == null or b.player==null:
		return false
	elif a.player.deviceNumber < b.player.deviceNumber:
		return true
	return false
####
