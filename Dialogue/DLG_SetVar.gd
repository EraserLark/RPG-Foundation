@tool
extends Step
class_name DLG_SetVar

@export var object: String
@export var property: String
enum OPERATORS {EQUALS, PLUS_EQUALS, MINUS_EQUALS, MULT_EQUALS, DIV_EQUALS}
@export var operator: OPERATORS = OPERATORS.EQUALS
@export var value: Dictionary = {0: "ChooseType"}

func runStep():
	match operator:
		OPERATORS.EQUALS:
			pass
			#object.property = value

func resumeStep():
	runStep()
