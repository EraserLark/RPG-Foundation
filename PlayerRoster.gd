extends Node

@export var profileBank: Array[PlayerInfo]
@export var roster: Array[Entity]	#Includes Empty Entities
#@export var activeRoster: Array[Entity]	#Bad idea? Only contains Initialized Entities

signal newRosterPlayer(info: PlayerInfo)

##Player joined, create Empty Entity
func addEmptySlot(stageManager: StageManager, joypadNum: int):
	var emptyEntity = OWEntity_Player.new()
	emptyEntity.overworldManager = stageManager
	emptyEntity.deviceNumber = joypadNum
	roster.append(emptyEntity)
	emptyEntity.rosterNumber = roster.find(emptyEntity)
	
	var emptyUI = stageManager.overworldUI.createPlayerUI(joypadNum)
	emptyEntity.entityUI = emptyUI
	emptyUI.playerPanel.setPlayer(emptyEntity)	#Do this mainly to get rosterNum to profileMenu
	stageManager.overworldUI.adjustMenusLayout()
	
	self.add_child(emptyEntity)	#Have entity show up in scene tree
	
	return emptyEntity

##Profile selected, initialize empty entity
func addProfileToRoster(profile: PlayerInfo, rosterNum: int):
	profile.initialize()
	var playerEntity = roster[rosterNum]
	playerEntity.entityInfo = profile
	##Create actor and initialize emptyUI
	var owManager = playerEntity.overworldManager
	owManager.overworldWorld.currentRoom.castList.addActor(playerEntity)
	owManager.overworldUI.initializePlayerUI(playerEntity.entityUI, playerEntity)
	##Initialize entity
	playerEntity.initialize(owManager, null)
	#profile.playerNumber = roster.size() - 1
	emit_signal("newRosterPlayer", profile)
