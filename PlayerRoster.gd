extends Node

@export var profileBank: Array[PlayerInfo]
@export var roster: Array[Entity]

signal newRosterPlayer(info: PlayerInfo)

func addEmptySlot(stageManager: StageManager):
	var emptyEntity = OWEntity_Player.new()
	roster.append(emptyEntity)
	emptyEntity.rosterNumber = roster.find(emptyEntity)
	
	var emptyUI = stageManager.overworldUI.createPlayerUI()
	emptyEntity.entityUI = emptyUI
	emptyUI.playerPanel.setPlayer(emptyEntity)
	stageManager.overworldUI.adjustMenusLayout()
	
	return emptyEntity

func addProfileToRoster(profile: PlayerInfo, rosterNum: int):
	profile.initialize()
	roster[rosterNum].entityInfo = profile
	#profile.playerNumber = roster.size() - 1
	emit_signal("newRosterPlayer", profile)

func grabNullSlot():
	var i:=0
	for slot in roster:
		if slot == null:
			return i
		else:
			i+=1
