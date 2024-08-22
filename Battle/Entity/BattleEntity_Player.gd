extends BattleEntity
class_name BattleEntity_Player

##Outside references
var playerUI: PlayerUI_Battle
var playerPanel: PlayerPanel_Battle
var playerNumber: int

##Inside vars
var playerActor: BattleActor_Player

##Signals
signal playerDied

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	super(om, bm)
	
	actor = bm.battleStage.playerActors[playerNumber]
	playerActor = actor
	playerUI = bm.battleUI.playerUIRoster[playerNumber]
	playerPanel = playerUI.playerPanel
	
	entityInfo.playerEntity = self
	entityInfo.entityUI = playerUI
	playerActor.player = self
	playerUI.player = self
	
	#if(entityInfo.attackList.is_empty()):
	entityInfo.setupAttacks(battleManager)
	
	#if(entityInfo.itemList.is_empty()):
	entityInfo.setupItems(battleManager)
	
	#if(entityInfo.miscList.is_empty()):
	entityInfo.setupMisc(battleManager)
	
	playerPanel.stats.changeHealth(entityInfo.hp)
	playerPanel.playerMenu.attackMenu.initMenu(entityInfo.attackList)
	playerPanel.playerMenu.itemMenu.initMenu(entityInfo.itemList)
	playerPanel.playerMenu.miscMenu.initMenu(entityInfo.miscList)
	
func attackChosen(attackNum: int):
	entityInfo.selectedAction = entityInfo.attackList[attackNum]
	return entityInfo.selectedAction

func actionChosen(actionNum: int):
	entityInfo.selectedAction = entityInfo.miscList[actionNum]
	return entityInfo.selectedAction

func itemChosen(itemNum: int):
	var item = entityInfo.itemList[itemNum]
	entityInfo.selectedAction = item.itemAction
	return entityInfo.selectedAction

func itemDiscarded(itemNum: int):
	entityInfo.itemList = Helper.removeIndex(entityInfo.itemList, itemNum)
	
	#Same as below, but ensures setter in array is called
	#entityInfo.itemList.remove_at(itemNum)

func attack():
	pass

func takeDamage(dmg: int, pierce: bool):
	super(dmg, pierce)

func gainHealth(amt: int):
	super(amt)

func updateUI(hp: int):
	playerPanel.changeStatsHealth(hp)

func checkRoster():
	var result = battleManager.battleRoster.checkPlayersAlive()
	return result

func entityDead():
	battleManager.battleRoster.players.erase(self)
	battleManager.battleRoster.checkPlayersAlive()
	super()

#func _on_animation_player_animation_finished(anim_name):
	#if(anim_name == "PlayerDamaged"):
		#emit_signal("reactionComplete")
	#elif(anim_name == "Death"):
		#entityDead()
