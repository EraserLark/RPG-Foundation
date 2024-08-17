@tool
extends Resource
class_name FlagList

@export var flags: Dictionary = {}: set = organizeFlags
#Key = String name of flag
#Value = bool

func organizeFlags(dict: Dictionary):
	#Do not reorganize dict if not adding a new entry to dict
	if dict.size() == flags.size():
		flags = dict
		if !Engine.is_editor_hint():
			notify_property_list_changed()
	else:
		var keys = dict.keys()
		keys.sort()
		
		var newDict = {}
		
		for key in keys:
			var value = dict[key]
			newDict[key] = value
		
		flags = newDict
		notify_property_list_changed()

func setFlag(flagName: String, condition: bool):
	flags[flagName] = condition
	print("Stall")
