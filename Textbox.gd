extends Panel
class_name Textbox

@onready var textPanel := self
@onready var textBox := $RichTextLabel
@onready var typeTimer := $Timer

@onready var typeAudio := $AudioStreamPlayer
var defaultTypeSpeed := 0.05
@export var line := "";
#var charIndex : int = 0
#var currentDialogue
var skip := false
var inTag := false
var finished := false
signal phraseFin()

#var typeSpeed = 30

func _ready():
	#typeText(line);
	pass

func _process(delta): #dialogueInput(event):
	if Input.is_action_just_pressed("ui_accept"): #event.is_action_pressed("ui_accept"):
		if finished == false:
			skip = true
			typeTimer.stop()
			typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
		else:
			textPanel.visible = false;

func typeText(newText : String):
	textBox.clear()
	showTextbox(true)
	setTimerSpeed(1) #Set type speed
	
	var currentDialogue = newText
	var charIndex = 0
	skip = false
	
	#for loop instead?
	while charIndex < currentDialogue.length():
		#https://youtu.be/jhwfA-QF54M?t=414
		checkTag(currentDialogue, charIndex)
		
		if !inTag:
			textBox.text += currentDialogue[charIndex]
			typeAudio.play()
			if !skip:
				typeTimer.start()
				await typeTimer.timeout
		
		charIndex += 1
	
	finished = true
	emit_signal("phraseFin")

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
