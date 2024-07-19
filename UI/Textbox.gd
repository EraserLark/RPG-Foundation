extends Panel
class_name Textbox

@onready var textPanel:= self
@onready var textBox:= $RichTextLabel
@onready var typeTimer:= $Timer
@onready var typeAudio:= $AudioStreamPlayer

@export var line:= "";

var defaultTypeSpeed:= 0.05
var skip:= false
var inTag:= false
var finished:= false

#https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#:~:text=(message)%5D)-,Stripping%20BBCode%20tags,another%20Control%20that%20does%20not%20support%20BBCode%20(such%20as%20a%20tooltip)%3A,-extends%20RichTextLabel%0A%0Afunc
var regex

signal phraseFin()
signal boxFin()

func _ready():
	regex = RegEx.new()
	regex.compile("\\[.*?\\]")

func typeText():
	textBox.text = line
	textBox.visible_characters = 0
	showTextbox(true)
	setTimerSpeed(1) #Set type speed
	
	var cleanText = regex.sub(line, "", true)	#Strips bbcode tags out of line
	var charIndex = 0
	finished = false
	skip = false
	
	#for loop instead?
	while charIndex < cleanText.length():
		#https://youtu.be/jhwfA-QF54M?t=414
		checkTag(cleanText, charIndex)
		
		if !inTag:
			#textBox.text += currentDialogue[charIndex]
			textBox.visible_characters += 1
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
	textBox.text = ""
	textPanel.visible = false
	emit_signal("boxFin")

#https://youtu.be/jhwfA-QF54M?t=403
func checkTag(fullText, characterIndex):
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
		elif inTag:
			if fullText[characterIndex - 1] == ">":
				inTag = false

func setTimerSpeed(multiplier):
	typeTimer.set_wait_time(defaultTypeSpeed * multiplier)

func setTimer(time):
	typeTimer.set_wait_time(time)

func setText(newText : String):
	textBox.text = newText

func showTextbox(condition : bool):
	textPanel.visible = condition
