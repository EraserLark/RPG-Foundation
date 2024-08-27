extends MenuSystem
class_name PlayerPanel

@onready var panelAnchorNodes:= $PanelAnchors
@onready var profileMenu:= $MarginContainer/ProfileSelection

var playerEntity: Entity

func open():
	if(playerEntity.entityInfo == null):
		showSubMenu(profileMenu)
	else:
		showSubMenu(baseMenu)

func setPlayer(pEntity: Entity):
	playerEntity = pEntity
	profileMenu.rosterNum = playerEntity.rosterNumber
