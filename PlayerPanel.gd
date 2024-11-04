extends MenuSystem
class_name PlayerPanel

@onready var panelAnchorNodes:= $PanelAnchors
@onready var profileMenu:= $MarginContainer/ProfileSelection

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
	
	moveTween = get_tree().create_tween()
	moveTween.tween_property(self, "position", targetPos, time).set_trans(trans)
