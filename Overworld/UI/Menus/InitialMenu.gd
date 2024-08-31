extends ManualMenu
class_name InitialMenu

##Prev Menu vars
@onready var manualMenu:= $ManualMenu
@onready var playerView:= $VBoxContainer/CenterContainer/TextureRect
@onready var healthLabel:= $VBoxContainer/RichTextLabel
var prevSelectIndex:= 0


#@export var playerNum: int = 0
@export var items : Array[String] = ["Apple", "Banana", "Cauliflower", "Durian", "Eggplant"] #"Fire flower", "Grapes", "Honeysuckle"]
@export var labelList: Control
@export var initialTimer: Timer
@export var echoTimer: Timer
var listSize: int

##Base Manual Menu
var currentSelection: int
var focusLabel: Label
#var arraySize: int
var inputTimerStarted:= false
var inputTimerFinished:= false
var initialInput:= true
var heldActionName: String
var currentTimer: Timer
#var input

##Cropped Menu
@export var upArrow: TextureRect
@export var downArrow: TextureRect
@export var visibleLabelCount = 4	#Acts as range determining whether to scroll
var upperScrollRange: int
var lowerScrollRange: int
var noCrop:= false

func OpenMenu():
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
	
	
	#grabFirstItem()	#Called in super()
	
	setHP()
	super()

func grabFirstFocus():
	currentSelection = 0
	
	focusLabel = labelList.get_child(currentSelection)
	focusLabel.theme_type_variation = "SelectLabel_Selected"

func runMenuUpdate(input: DeviceInput):
	if input.is_action_pressed("ui_down"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_down"
			
			currentSelection += 1
			#currentSelection %= listSize
			selectItem()
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection += 1
			#currentSelection %= listSize
			selectItem()
			
			currentTimer = echoTimer
			currentTimer.start()
	elif input.is_action_pressed("ui_up"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_up"
			
			currentSelection -= 1
			#currentSelection %= listSize
			selectItem()
			
			initialInput = false
			currentTimer = initialTimer
			currentTimer.start()
			
		elif inputTimerFinished:
			inputTimerFinished = false
			
			currentSelection -= 1
			#currentSelection %= listSize
			selectItem()
			
			currentTimer = echoTimer
			currentTimer.start()
	elif heldActionName != "":
		if input.is_action_just_released(heldActionName):
			currentTimer.stop()
			#heldActionName = ""
			initialInput = true

func selectItem():
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

func activateOption():
	focusLabel.theme_type_variation = "SelectLabel_Activated"
	menuManager.showInitialMenuSelection(currentSelection)

func setHP():
	healthLabel.text = str("HP: ", menuManager.playerInfo.hp, "/", menuManager.playerInfo.hpMax)

func setPrevFocus():
	#Store prevFocus as int here
	pass

func grabPrevFocus():
	pass


func _on_initial_timer_timeout():
	inputTimerFinished = true

func _on_echo_timer_timeout():
	inputTimerFinished = true
