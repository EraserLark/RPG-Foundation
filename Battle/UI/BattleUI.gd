extends Stage_UI
class_name Battle_UI

##Preload vars
#var playerUIScene:= preload("res://Battle/UI/PlayerUI_Battle.tscn")

##Children references
#@onready var playerUI:= $PlayerUI
@onready var tbContainer:= $TBContainer
#@onready var playerAnchors:= $PlayerAnchors

##Parent references
var battleManager: BattleManager

##Inside vars
#var playerUIRoster: Array[PlayerUI_Battle]

func _ready():
	pass
	#Determine UI anchors based off how many players are currently playing
	
	#for player in PlayerRoster.roster:
		##Instance a player menu for each player in the PlayerRoster. Child of self.
		#var pUI = playerUIScene.instantiate()
		#add_child(pUI)
		##Add it to playerUIRoster
		#player.battleUI = pUI
		#playerUIRoster.append(pUI)

func initialize(sm: StageManager):
	super(sm)
