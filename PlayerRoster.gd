extends Node

@export var profileBank: Array[PlayerInfo]
@export var roster: Array[PlayerInfo]

signal newRosterPlayer(info: PlayerInfo)

func _ready():
	pass
	#for x in roster.size():
		#roster[x].playerNumber = x
		#roster[x].initialize()

func addEmptySlot():
	roster.append(null)

func addProfileToRoster(profile: PlayerInfo):
	profile.initialize()
	var slotNum = grabNullSlot()
	roster[slotNum] = profile
	profile.playerNumber = roster.size() - 1
	emit_signal("newRosterPlayer", profile)

func grabNullSlot():
	var i:=0
	for slot in roster:
		if slot == null:
			return i
		else:
			i+=1
