@tool
extends Step
class_name DLG_SetFlags

@export var setTo: bool
@export var scope: String = "World": set = setScope
@export var zone: String: set = setZone
@export var room: String: set = setRoom
@export var section: String: set = setSection
@export var member: String: set = setMember
@export var flagName: String

var scopeKeyArray: Array[String]
var zoneKeyArray: Array[String]
var roomKeyArray: Array[String]
var sectionKeyArray: Array[String]
var memberKeyArray: Array[String]
var flagKeyArray: Array[String]

func runStep():
	var flagOptions = FlagManager.flags[scope][zone][room][section][member]#.flags
	flagOptions.setFlag(flagName, setTo)
	print(str("Flag: ", flagName, " is set to: ", flagOptions.flags[flagName]))
	print(str("Resource changed: ", FlagManager.flags[scope][zone][room][section][member]))
	advanceNextStep(self)

func resumeStep():
	runStep()

func _enter_tree():
	refreshScope()

func refreshScope():
	scopeKeyArray.assign(FlagManager.flags.keys())
	print(str("Scope Array: ", scopeKeyArray))
	if(scopeKeyArray.is_empty()):
		return
	else:
		zoneKeyArray.assign(FlagManager.flags[scope].keys())
		print(str("Zone Array: ", zoneKeyArray))
		if(zoneKeyArray.is_empty()):
			print("Zone keys empty")
			zone = ""
			room = ""
			section = ""
			member = ""
			flagName = ""
			return
		elif(zone == ""):
			print("Zone not set")
			return
		else:
			roomKeyArray.assign(FlagManager.flags[scope][zone].keys())
			print(str("Room Array: ", roomKeyArray))
			if(roomKeyArray.is_empty()):
				print("Room keys empty")
				room = ""
				section = ""
				sectionKeyArray.clear()
				member = ""
				memberKeyArray.clear()
				flagName = ""
				flagKeyArray.clear()
				return
			elif(room == ""):
				print("Room not set")
				return
			else:
				sectionKeyArray.assign(FlagManager.flags[scope][zone][room].keys())
				print(str("Section Array: ", sectionKeyArray))
				if(sectionKeyArray.is_empty()):
					print("Section keys empty")
					section = ""
					sectionKeyArray.clear()
					member = ""
					memberKeyArray.clear()
					flagName = ""
					flagKeyArray.clear()
					return
				elif(section == ""):
					print("Section not set")
					return
				else:
					memberKeyArray.assign(FlagManager.flags[scope][zone][room][section].keys())
					print(str("Member Array: ", memberKeyArray))
					if(memberKeyArray.is_empty()):
						print("Member keys empty")
						member = ""
						memberKeyArray.clear()
						flagName = ""
						flagKeyArray.clear()
						return
					elif(member == ""):
						print("Member not set")
						return
					else:
						flagKeyArray.assign(FlagManager.flags[scope][zone][room][section][member].flags.keys())
						print(str("Flag Array: ", flagKeyArray))
						if(flagKeyArray.is_empty()):
							print("Flag keys empty")
							flagName = ""
							flagKeyArray.clear()
							return
						elif(flagName == ""):
							print("Flag not set")
							return
						else:
							print("FLAG SELECTED")

func _get_property_list() -> Array:
	var properties = []
	
	properties.append({
		"name": "scope",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(scopeKeyArray)
	})
	properties.append({
		"name": "zone",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(zoneKeyArray)
	})
	properties.append({
		"name": "room",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(roomKeyArray)
	})
	properties.append({
		"name": "section",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(sectionKeyArray)
	})
	properties.append({
		"name": "member",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(memberKeyArray)
	})
	properties.append({
		"name": "flagName",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": Helper.arrayToString(flagKeyArray)
	})
	
	return properties

func setScope(value):
	print("Scope set")
	scope = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()

func setZone(value):
	print("Zone set")
	zone = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()

func setRoom(value):
	print("Room set")
	room = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()

func setSection(value):
	print("Section set")
	section = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()

func setMember(value):
	member = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()

func setFlag(value):
	flagName = value
	if(value != ""):
		refreshScope()
	notify_property_list_changed()
