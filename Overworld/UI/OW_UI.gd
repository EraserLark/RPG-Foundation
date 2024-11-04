extends Stage_UI
class_name Overworld_UI

@onready var tbContainer:= $TBContainer
@onready var fadeScreen:= $Fade

##Parent references
var owManager: OverworldManager

func _ready():
	pass

#Runs after all nodes have finished _ready()
func initialize(sm: StageManager):
	super(sm)

func initializePlayerUI(pUI: PlayerUI, pEntity: PlayerEntity):
	super(pUI, pEntity)
	#Hide menu when first starting game
	pUI.playerPanel.visible = false
