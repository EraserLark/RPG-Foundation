extends State

signal send_message(message : String)
signal endBattle()

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	#StateMachineStack.addSM(stateMachine)
	emit_signal("send_message", "Battle Start!!")

func update(delta : float):
	if Input.is_action_just_pressed("ui_cancel"):
		stateMachine.endStateMachine()

func physicsUpdate(delta : float):
	pass

func exit():
	StateMachineStack.removeSM()
	emit_signal("endBattle")
