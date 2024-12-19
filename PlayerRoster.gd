extends Node

@export var profileBank: Array[PlayerInfo]
@export var roster: Array[PlayerEntity]	#Includes Empty Entities
@export var rosterColors: Array[Color]

signal newRosterPlayer(info: PlayerInfo)
signal discardRosterPlayer(info: PlayerInfo)

func _ready():
	InputManager.playerLeft.connect(removePlayer)

###GETTERS
##Filters out empty entities
func getActiveRoster() -> Array[PlayerEntity]:
	var activeRoster: Array[PlayerEntity]
	for player in roster:
		if player.entityInfo != null:
			activeRoster.append(player)
	return activeRoster

func getLivingRoster() -> Array[PlayerEntity]:
	var livingRoster: Array[PlayerEntity]
	var activeRoster: Array[PlayerEntity] = getActiveRoster()
	for player in activeRoster:
		if !player.isDead:
			livingRoster.append(player)
	return livingRoster

func getPlayerByRosterNum(rosterNum: int) -> PlayerEntity:
	if roster[rosterNum] != null:
		return roster[rosterNum]
	else:
		printerr("That number slot in the player roster is empty")
		return null

func getPlayerByJoyNum(joyNum: int) -> PlayerEntity:
	for player in roster:
		if player.deviceNumber == joyNum:
			return player
	printerr("No Player has that joypad number")
	return null


##Player joined, create Empty Entity
func addEmptySlot(stageManager: StageManager, joypadNum: int):
	var emptyEntity = PlayerEntity.new()
	
	if stageManager is BattleManager:
		emptyEntity.battleManager = stageManager
	else:
		emptyEntity.overworldManager = stageManager
	
	emptyEntity.setDeviceNumber(joypadNum)
	roster.append(emptyEntity)
	roster.sort_custom(sortPlayerEntities)	#Sort to adjust to new device numbers
	emptyEntity.setRosterNumber(roster.find(emptyEntity))
	#emptyEntity.playerStateStack.playerNumber = emptyEntity.rosterNumber
	
	##Creating Stage UI + Updating UI positions
	var emptyUI = stageManager.stageUI.createPlayerUI(emptyEntity.rosterNumber)
	
	#Do this for Profile ManualMenu State
	##Actual setting of this UI happens in PlayerUI class
	if stageManager is BattleManager:
		emptyEntity.battleUI = emptyUI
	else:
		emptyEntity.worldUI = emptyUI
	
	emptyUI.playerPanel.setPlayer(emptyEntity)	#Do this mainly to get rosterNum to profileMenu
	self.add_child(emptyEntity)	#Have entity show up in scene tree
	
	return emptyEntity

##Profile selected, initialize empty entity
func addProfileToRoster(profile: PlayerInfo, rosterNum: int):
	profile.initialize()
	var playerEntity = roster[rosterNum]
	playerEntity.entityInfo = profile
	playerEntity.entityInfo.playerEntity = playerEntity
	
	##Create actor and initialize emptyUI
	var stageManager: StageManager
	#if playerEntity.battleManager != null:
		#stageManager = playerEntity.battleManager
		#stageManager.battleStage.addPlayerActor(playerEntity)
		#stageManager.stageUI.initializePlayerUI(playerEntity.battleUI, playerEntity)
	#else:
	stageManager = playerEntity.overworldManager
	stageManager.overworldWorld.currentRoom.castList.addActor(playerEntity)
	stageManager.stageUI.initializePlayerUI(playerEntity.worldUI, playerEntity)
	
	##Initialize entity
	playerEntity.initialize(stageManager)
	
	newRosterPlayer.emit(profile)

func removePlayer(deviceNum: int):
	var leavingPlayer: PlayerEntity
	for player in roster:
		if player.deviceNumber == deviceNum:
			leavingPlayer = player
	
	if leavingPlayer == null:
		printerr("Could not find leaving device number amongst player entity roster")
		return
	
	var stageManager = leavingPlayer.overworldManager
	
	#Erase playerEntity from roster, sort roster, queue free
	roster.erase(leavingPlayer)
	roster.sort_custom(sortPlayerEntities)
	#Erase playerUI from playerUIRoster, sort roster, queue free
	stageManager.stageUI.removePlayerUI(leavingPlayer.worldUI)
	stageManager.stageUI.adjustMenusLayout()
		#Erase playerActor from playerActors, sort roster, queue free
	if leavingPlayer.entityInfo != null:
		stageManager.overworldWorld.currentRoom.castList.removeActor(leavingPlayer.worldActor)
	
	discardRosterPlayer.emit(leavingPlayer.entityInfo)
	leavingPlayer.queue_free()

##Used for sort_custom
func sortPlayerEntities(a, b):
	if a.deviceNumber < b.deviceNumber:
		return true
	return false
####
