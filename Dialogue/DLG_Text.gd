extends Step
class_name DLG_Text

#func _init(dm: DialogueManager = null):
	#super(dm)

func runStep():
	print("This is a text step")
	nextStep(self)
	#Create Textbox state with all the info you need
	#May need to tweak this so that you don't have to create a textbox state for
	#the textboxes...

func resumeStep():
	nextStep(self)
