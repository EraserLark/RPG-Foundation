extends ManualMenu
class_name MM_Cropped

@export_category("Nodes")
@export var labelList: Control
@export var initialTimer: Timer
@export var echoTimer: Timer
@export var upArrow: Texture
@export var downArrow: Texture
@export_category("Values")
@export var playerNum: int = 0
@export var items: Array[String]
@export var visibleLabelCount = 4	#Acts as range determining whether to scroll

var listSize: int

#Base Manual Menu
var currentSelection: int
var focusLabel: Label
var arraySize: int
var inputTimerStarted:= false
var inputTimerFinished:= false
var initialInput:= true
var heldActionName: String
var currentTimer: Timer
var input: DeviceInput

#Cropped Menu
var upperScrollRange: int
var lowerScrollRange: int
var noCrop:= false


func _ready():
	input = DeviceInput.new(playerNum)
	
	listSize = items.size()
	
	##Determine if menu will need cropping
	if listSize <= visibleLabelCount:
		noCrop = true
	
	if noCrop:
		##Clear all labels
		for i in visibleLabelCount:
			var setLabel = labelList.get_child(i)
			setLabel.text = ""
		
		##Set label names
		for i in listSize:
			var setLabel = labelList.get_child(i)
			setLabel.text = items[i]
		
		lowerScrollRange = 0
		upperScrollRange = listSize
		
		upArrow.visible = false
		downArrow.visible = false
	else:
		for i in visibleLabelCount:
			var setLabel = labelList.get_child(i)
			setLabel.text = items[i]
		
		lowerScrollRange = 0
		upperScrollRange = visibleLabelCount
	
	
	grabFirstItem()

func _unhandled_input(event: InputEvent) -> void:
	###Route 2
	var actionName = "ui_accept"
	
	if input.is_joypad():
		actionName.insert(0, str(playerNum))
	if(event.is_action_pressed(actionName)):
		var selectedIndex = confirmSelection()
		print(str("Item selected: ", items[selectedIndex]))

func _process(delta: float) -> void:
	if input.is_action_pressed("ui_down"):
		if initialInput:
			heldActionName = "ui_down"
			
			currentSelection += 1
			#currentSelection %= listSize
			grabItem()
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection += 1
			#currentSelection %= listSize
			grabItem()
			
			currentTimer = echoTimer
			currentTimer.start()
	elif input.is_action_pressed("ui_up"):
		if initialInput:
			heldActionName = "ui_up"
			
			currentSelection -= 1
			#currentSelection %= listSize
			grabItem()
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection -= 1
			#currentSelection %= listSize
			grabItem()
			
			currentTimer = echoTimer
			currentTimer.start()
	elif heldActionName != "":
		if input.is_action_just_released(heldActionName):
			currentTimer.stop()
			#heldActionName = ""
			initialInput = true

func grabFirstItem():
	currentSelection = 0
	
	focusLabel = labelList.get_child(currentSelection)
	focusLabel.theme_type_variation = "SelectLabel_Selected"

func grabItem():
	focusLabel.theme_type_variation = "SelectLabel"
	var focusIndex: int
	
	if noCrop:
		if currentSelection >= upperScrollRange:
			currentSelection = 0
		elif currentSelection < lowerScrollRange:
			currentSelection = upperScrollRange-1
		focusIndex = currentSelection
	else:
		if currentSelection >= upperScrollRange:
			if currentSelection >= listSize:
				currentSelection = 0
				upperScrollRange = visibleLabelCount
				lowerScrollRange = 0
			else:
				#Update upper/lower ranges to include the new currentSelection
				upperScrollRange += 1
				lowerScrollRange += 1
			#Get names for items 1-5, assign them to labels
			for i in visibleLabelCount:
				var setLabel = labelList.get_child(i)
				setLabel.text = items[i+lowerScrollRange]
			#Within new range, determine which relative label should be selected for currentSelection (currentSelection)
			focusIndex = currentSelection-lowerScrollRange
		elif currentSelection < lowerScrollRange:
			if currentSelection < 0:
				currentSelection = listSize - 1
				upperScrollRange = listSize
				lowerScrollRange = upperScrollRange - visibleLabelCount
			else:
				#Update upper/lower ranges to include the new currentSelection
				upperScrollRange -= 1
				lowerScrollRange -= 1
			#Get names for items 1-5, assign them to labels
			for i in visibleLabelCount:
				var setLabel = labelList.get_child(i)
				setLabel.text = items[i+lowerScrollRange]
			#Within new range, determine which relative label should be selected for currentSelection (currentSelection)
			focusIndex = currentSelection-lowerScrollRange
		else:
			focusIndex = currentSelection - lowerScrollRange
	
	##Set arrows visible
	if !noCrop:
		upArrow.visible = true
		downArrow.visible = true
		if lowerScrollRange == 0:
			upArrow.visible = false
		if upperScrollRange >= listSize:
			downArrow.visible = false
	
	##Set label theme
	focusLabel = labelList.get_child(focusIndex)
	focusLabel.theme_type_variation = "SelectLabel_Selected"
	
	print(str("CurrentSelection: ", currentSelection, "  UpperScrollRange: ", upperScrollRange))

func confirmSelection():
	focusLabel.theme_type_variation = "SelectLabel_Activated"
	return currentSelection

func _on_initial_timer_timeout() -> void:
	inputTimerFinished = true

func _on_echo_timer_timeout() -> void:
	inputTimerFinished = true
