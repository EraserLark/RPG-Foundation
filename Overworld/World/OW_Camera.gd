extends Camera2D

##Children references
#None

##Parent references
#var world	#unused?
var castList: CastList

##Non export vars
var target = null;

func initialize(om: OverworldManager, rm: Room):
	castList = rm.castList

func setTarget(newTarget: Node2D):
	target = newTarget

func _process(delta):
	if(target):
		self.position = target.position
