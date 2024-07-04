extends State

signal moveToPromptPhase
signal send_message(message : String)
signal endBattle()

func handleInput(event : InputEvent):
	pass

func enter(msg := {}):
	#StateMachineStack.addSM(stateMachine)
	emit_signal("send_message", "Battle Start!!")

func update(delta : float):
	if Input.is_action_just_pressed("ui_cancel"):
		exit()

func physicsUpdate(delta : float):
	pass

func exit():
	pass

func _on_battle_ui_finish_start_phase():
	emit_signal("moveToPromptPhase")
