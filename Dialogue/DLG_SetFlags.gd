@tool
extends Step
class_name DLG_SetFlags

@export var setTo: bool
@export var scope: String = "World"
@export var zone: String
@export var room: String
@export var section: String
@export var member: String
@export var flagName: String

func runStep():
	var flagOptions = FlagManager.flags[scope][zone][room][section][member]#.flags
	flagOptions.setFlag(flagName, setTo)
	print(str("Flag: ", flagName, " is set to: ", flagOptions.flags[flagName]))
	print(str("Resource changed: ", FlagManager.flags[scope][zone][room][section][member]))
	advanceNextStep(self)

func resumeStep():
	runStep()
