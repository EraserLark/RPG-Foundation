extends Control
class_name Textbox

static var scenePath = "res://UI/textbox.tscn"

@onready var textPanel:= self
@onready var textField:= $RichTextLabel
@onready var typeTimer:= $Timer
@onready var typeAudio:= $AudioStreamPlayer

var lineQueue: Array[String]
@export var currentLine:= "";

var defaultTypeSpeed:= 0.05
var skip:= false
var inTag:= false
var finished:= false

#https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#:~:text=(message)%5D)-,Stripping%20BBCode%20tags,another%20Control%20that%20does%20not%20support%20BBCode%20(such%20as%20a%20tooltip)%3A,-extends%20RichTextLabel%0A%0Afunc
var regex

#signal phraseFin()
#signal boxFin()

static func createInstance(parent: Node, lines: Array[String], screenPos: Vector2, dimensions: Vector2):
	var scene = load(scenePath)
	var inst = scene.instatiate()
	parent.add_child(inst)
	
	inst.lineQueue = lines
	inst.textPanel.set_position(screenPos)
	inst.textPanel.set_size(dimensions)
	
	return inst

func _ready():
	regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	
	advanceLineQueue()

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
		closeTextbox()

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
	
	finished = true
	emit_signal("phraseFin")

func openBox():
	textPanel.visible = true

func closeBox():
	textField.text = ""
	textPanel.visible = false
	emit_signal("boxFin")

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

func closeTextbox():
	StateStack.resumeCurrentState()
	self.queue_free()

func setTimerSpeed(multiplier):
	typeTimer.set_wait_time(defaultTypeSpeed * multiplier)

func setTimer(time):
	typeTimer.set_wait_time(time)

func setText(newText : String):
	textField.text = newText

func showTextbox(condition : bool):
	textPanel.visible = condition
