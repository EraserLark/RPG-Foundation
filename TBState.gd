extends State

func enter(msg := {}):
	super()
	owner.openBox()
	owner.typeText()
	

func update(delta : float):
	if Input.is_action_just_pressed("ui_accept"): #event.is_action_pressed("ui_accept"):
		if owner.finished == false:
			owner.skip = true
			owner.typeTimer.stop()
			owner.typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
		else:
			stateMachine.endStateMachine()

func exit():
	owner.closeBox()
	StateMachineStack.removeSM()
