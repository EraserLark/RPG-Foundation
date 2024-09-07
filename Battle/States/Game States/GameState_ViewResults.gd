extends GameState
class_name GameState_BattleResults

var battleManager: BattleManager
var submitCount:= 0

static func createEvent(eManager, bm):
	var resultsEvent = EventClass.new(eManager, bm)
	eManager.addEvent(resultsEvent)

func _init(bm:BattleManager, _msg := {}):
	battleManager = bm
	super()

func stackEnter(_msg := {}):
	for playerEntity in PlayerRoster.getLivingRoster():
		var connectionState = GameState_Connection.new(playerEntity.playerStateStack, self)
		playerEntity.playerStateStack.addState(connectionState)	#Enters game state roundabout

func enter(playerNum: int, _msg:= {}):
	var playerEntity = PlayerRoster.roster[playerNum]
	var playerInfo = playerEntity.entityInfo
	playerInfo.xp += battleManager.xpBank
	
	var message: Array[String] = [str("You win! Gained ", battleManager.xpBank, "xp!")]
	
	if(playerInfo.xp >= playerInfo.nextLevelCost):
		message += ["[rainbow]LEVEL UP![/rainbow]", str("You are now Level ", playerEntity.entityInfo.level)]
	
	var playerPanel = playerEntity.battleUI.playerPanel
	var tbContainer = playerPanel
	playerPanel.showPlayerMenu(true)	#gross, will be obsolete soon
	var tbState = Textbox_State.new(playerEntity.playerStateStack, message, tbContainer)
	playerEntity.playerStateStack.addState(tbState)

#Runs the 'resumeState()' func in each player's GameState_Connection state
func stackResume():
	super()

func resumeState(playerNum: int):
	playerSubmit()

###For button presses
#func handleInput(playerNum: int, _event: InputEvent):
	#if _event.device != PlayerRoster.roster[playerNum].deviceNumber:
		#return
	#
	#menuSystems[playerNum].menuStack.currentMenu.buttonPressed(_event)

func playerSubmit():
	submitCount += 1
	if submitCount >= PlayerRoster.getActiveRoster().size():
		stackExit()

func stackExit():
	super()


class EventClass:
	#class_name CutsceneEvent
	extends Event
	
	var battleManager
	
	func _init(eManager, bm):
		super(eManager)
		battleManager = bm
	
	func runEvent():
		#var cutscene = cutsceneClass.new(stageManager.cutsceneManager, stageManager)
		GameState_BattleResults.new(battleManager)
	
	func resumeEvent():
		finishEvent()
