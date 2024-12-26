extends Stage_UI
class_name Battle_UI

##Children references
@onready var tbContainer:= $TBContainer

##Parent references
var battleManager: BattleManager

func initialize(sm: StageManager):
	super(sm)
