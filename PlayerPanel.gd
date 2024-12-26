extends MenuSystem
class_name PlayerPanel

@onready var panel:= $Panel
@onready var panelAnchorNodes:= $Panel/PanelAnchors
@onready var profileMenu:= $Panel/MarginContainer/ProfileSelection

var playerUI: PlayerUI

var playerEntity: Entity
var moveTween: Tween

func open(sStack: StateStack):
	ownerStack = sStack
	if(playerEntity.entityInfo == null):
		showSubMenu(profileMenu)
	else:
		showSubMenu(baseMenu)

func setPlayer(pEntity: Entity):
	playerEntity = pEntity
	profileMenu.rosterNum = playerEntity.rosterNumber

func movePanel(targetPos: Vector2, time: float = 1, trans = Tween.TRANS_SINE):
	if moveTween:
		moveTween.kill()
	
	var offsetPos = determineOffset(targetPos)
	targetPos = offsetPos
	
	moveTween = get_tree().create_tween()
	moveTween.tween_property(self, "position", targetPos, time).set_trans(trans)

func determineOffset(targetPos: Vector2) -> Vector2:
	var offset = targetPos.y
	#Get current panel anchor number
	var panelAnchNum = playerUI.panelAnchorNum
	#If it is a top anchor, add offset
	if panelAnchNum <= 2:
		offset += panel.size.y/2
	#If bottom anchor, subtract
	else:
		offset -= panel.size.y/2
	return Vector2(targetPos.x, offset)
