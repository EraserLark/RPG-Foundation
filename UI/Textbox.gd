extends Control
class_name Textbox

static var scenePath = "res://UI/textbox.tscn"
var ownerState: State

@onready var responsePanel:= $ResponsePanel
@onready var textField:= $NinePatchRect/MarginContainer/RichTextLabel
@onready var typeTimer:= $Timer
@onready var typeAudio:= $AudioStreamPlayer
@onready var boxBG:= $NinePatchRect

var lineQueue: Array[String]
@export var currentLine:= "";
@export var responseOptions: Array[String]

var target

var defaultTypeSpeed:= 0.05
var skip:= false
var inTag:= false
var finished:= false
var tbFinished:= false

#https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#:~:text=(message)%5D)-,Stripping%20BBCode%20tags,another%20Control%20that%20does%20not%20support%20BBCode%20(such%20as%20a%20tooltip)%3A,-extends%20RichTextLabel%0A%0Afunc
var regex

enum MODE {DIALOGUE, CHOICE}
var currentMode: MODE = MODE.DIALOGUE

signal responseChosen(responseIndex: int)

static func createInstance(parent: Node, lines: Array[String], stateOwner: State, responseOptions: Array[String] = []) -> Textbox:
	var scene = load(scenePath)
	var inst = scene.instantiate()
	parent.add_child(inst)
	
	inst.lineQueue = lines.duplicate()
	inst.target = parent
	inst.responseOptions = responseOptions
	inst.ownerState = stateOwner
	
	return inst

func _ready():
	regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	
	responsePanel.responseSelected.connect(submitResponse)
	currentMode = MODE.DIALOGUE

func _on_gui_input(event):
	#if(event.is_action_pressed("ui_accept")):
		#accept_event()
		#advance()
	pass

func confirmInput():
	match currentMode:
		MODE.DIALOGUE:
			advance()
		MODE.CHOICE:
			responsePanel.confirmInput()

func moveInput(input: Vector2):
	if currentMode == MODE.CHOICE:
		responsePanel.moveInput(input)

func advance(): 
	#Skip to end of line
	if finished == false:
		skip = true
		typeTimer.stop()
		typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
	#Line is finished, advance
	else:
		advanceLineQueue()

func advanceLineQueue():
	if(lineQueue.size() > 0):
		currentLine = lineQueue.pop_front()
		typeText(currentLine)
	else:
		finishTextbox()
		ownerState.stateStack.resumeCurrentState()

func typeText(textToType: String):
	textField.text = textToType
	textField.visible_characters = 0
	showTextbox(true)
	setTimerSpeed(1) #Set type speed
	
	var cleanText = regex.sub(textToType, "", true)	#Strips bbcode tags out of line
	var charIndex = 0
	finished = false
	skip = false
	
	#for loop instead?
	while charIndex < cleanText.length():
		#https://youtu.be/jhwfA-QF54M?t=414
		checkTag(cleanText, charIndex)
		
		if !inTag:
			#textField.text += currentDialogue[charIndex]
			textField.visible_characters += 1
			typeAudio.play()
			if !skip:
				typeTimer.start()
				await typeTimer.timeout
		
		charIndex += 1
	
	if(responseOptions.is_empty()):
		finishTextbox()
	else:
		currentMode = MODE.CHOICE
		showResponsePanel()

#https://youtu.be/jhwfA-QF54M?t=403
func checkTag(fullText, characterIndex):
		setTimer(defaultTypeSpeed)
		if fullText[characterIndex] == "<":
			inTag = true
			var nextChar = fullText[characterIndex + 1]
			
			#Typing Speed
			if nextChar == "S":
				var customWaitMult = int(fullText[characterIndex + 2])
				setTimerSpeed(customWaitMult)
			#Pause Typing
			elif nextChar == "P":
				var pauseTime = int(fullText[characterIndex + 2])
				setTimer(pauseTime)
		elif fullText[characterIndex] == ".":
			setTimer(.25)
		elif inTag:
			if fullText[characterIndex - 1] == ">":
				inTag = false

func finishTextbox():
	finished = true

func closeTextbox():
	tbFinished = true
	self.queue_free()

func setTimerSpeed(multiplier):
	typeTimer.set_wait_time(defaultTypeSpeed * multiplier)

func setTimer(time):
	typeTimer.set_wait_time(time)

func setText(newText : String):
	textField.text = newText

func showTextbox(condition : bool):
	boxBG.visible = condition

func showResponsePanel():
	if(responseOptions.is_empty()):
		printerr("Response Options is empty!")
	else:
		responsePanel.initMenu(responseOptions)
		await responsePanel.resized		#A single physics frame :P
		var panelWidth = responsePanel.getPanelWidth()
		var textboxWidth = boxBG.size.x
		var textboxHeight = boxBG.size.y
		var newTBWidth = textboxWidth - panelWidth
		boxBG.set_size(Vector2(newTBWidth, textboxHeight))

func submitResponse(responseNum: int):
	print(str("Selected ", responseOptions[responseNum]))
	emit_signal("responseChosen", responseNum)
	#hideResponsePanel()
	finishTextbox()
	advanceLineQueue()

func hideResponsePanel():
	pass
