extends MinigameFoundation
class_name MG_MashMeter

@onready var mashBar:= $Stage/ProgressBar
var meterAmt: float

func _ready():
	super()

func buttonPressed(_event: InputEvent):
	if _event.is_action_pressed("ui_accept"):
		addMeter()

func update(delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#addMeter()
	#
	meterAmt -= 0.25
	if(meterAmt <= 0):
		meterAmt = 0
	mashBar.value = meterAmt
	
	super(delta)

func addMeter():
	meterAmt += 7.5

func wrapUp():
	successPercent = meterAmt
	super()

func judgeSuccess():
	if(successPercent == 100):
		return 1
	elif(successPercent >= 50):
		return 0
	elif(successPercent < 50):
		return -999

func endMinigame():
	self.queue_free()
