extends ManualMenu
class_name ManualMenu_ButtonList

###Children references
#@onready var attackButton:= $"AttackButton"
#
###Parent references
#@onready var attackMenu:= $"../MarginContainer/AttackMenu"
#@onready var itemMenu:= $"../MarginContainer/ItemMenu"
#@onready var miscMenu:= $"../MarginContainer/MiscMenu"

#@export var items: Array[String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
@export var buttonList: Control
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
@export var visibleButtonCount = 6	#Acts as range determining whether to scroll
var upperScrollRange: int
var lowerScrollRange: int
var noCrop:= false

signal optionActivated(itemNum: int)

func OpenMenu():
	listSize = buttonList.get_child_count()
	
	##Determine if menu will need cropping
	if listSize <= visibleButtonCount:
		noCrop = true
	
	if noCrop:
		###Clear all labels
		#for i in visibleButtonCount:
			#var setLabel = buttonList.get_child(i)
			#setLabel.text = ""
		
		###Set label names
		#for i in listSize:
			#var setLabel = buttonList.get_child(i)
			#setLabel.text = items[i]
		
		lowerScrollRange = 0
		upperScrollRange = listSize
		
		upArrow.visible = false
		downArrow.visible = false
	else:
		#for i in visibleButtonCount:
			#var setLabel = buttonList.get_child(i)
			#setLabel.text = items[i]
		
		lowerScrollRange = 0
		upperScrollRange = visibleButtonCount
	
	
	#grabFirstItem()	#Called in super()
	
	super()

func grabFirstFocus():
	currentSelection = prevFocus
	
	focusLabel = buttonList.get_child(currentSelection)
	focusLabel.theme_type_variation = "Selected"

func runMenuUpdate(input: DeviceInput):
	if input.is_action_pressed("ui_right"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_right"
			
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
	elif input.is_action_pressed("ui_left"):
		if initialInput:
			inputTimerFinished = false
			heldActionName = "ui_left"
			
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
	focusLabel.theme_type_variation = "SelectButton"
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
				upperScrollRange = visibleButtonCount
				lowerScrollRange = 0
			else:
				#Update upper/lower ranges to include the new currentSelection
				upperScrollRange += 1
				lowerScrollRange += 1
			#Get names for items 1-5, assign them to labels
			for i in visibleButtonCount:
				var setLabel = buttonList.get_child(i)
				#setLabel.text = items[i+lowerScrollRange]
			#Within new range, determine which relative label should be selected for currentSelection (currentSelection)
			focusIndex = currentSelection-lowerScrollRange
		elif currentSelection < lowerScrollRange:
			if currentSelection < 0:
				currentSelection = listSize - 1
				upperScrollRange = listSize
				lowerScrollRange = upperScrollRange - visibleButtonCount
			else:
				#Update upper/lower ranges to include the new currentSelection
				upperScrollRange -= 1
				lowerScrollRange -= 1
			#Get names for items 1-5, assign them to labels
			for i in visibleButtonCount:
				var setLabel = buttonList.get_child(i)
				#setLabel.text = items[i+lowerScrollRange]
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
	focusLabel = buttonList.get_child(focusIndex)
	focusLabel.theme_type_variation = "Selected"
	
	print(str("Menu: ", self.name, "  CurrentSelection: ", currentSelection, "  UpperScrollRange: ", upperScrollRange))

func activateOption():
	focusLabel.theme_type_variation = "Activated"
	emit_signal("optionActivated", currentSelection)

func setPrevFocus():
	#Store prevFocus as int here
	prevFocus = currentSelection

func grabPrevFocus():
	currentSelection = prevFocus


func _on_initial_timer_timeout():
	inputTimerFinished = true

func _on_echo_timer_timeout():
	inputTimerFinished = true


#func _on_attack_button_button_down():
	#menuManager.showSubMenu(attackMenu)
#
#func _on_item_button_button_down():
	#menuManager.showSubMenu(itemMenu)
#
#func _on_react_button_button_down():
	#menuManager.showSubMenu(miscMenu)
