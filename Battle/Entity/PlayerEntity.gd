extends Entity
class_name PlayerEntity

var playerUI: Control
var playerPanel: PlayerPanel

signal playerDied

func initialize(bm: BattleManager):
	super(bm)
	
	actor = bm.playerActor
	playerUI = bm.playerUI
	playerPanel = bm.playerPanel
	
	localInfo.playerEntity = self
	actor.player = self
	playerUI.player = self
	
	if(localInfo.actionList.is_empty()):
		localInfo.setupAttacks(battleManager)
	
	if(localInfo.itemList.is_empty()):
		localInfo.setupItems(battleManager)
	
	if(localInfo.miscList.is_empty()):
		localInfo.setupMisc(battleManager)
	
	playerPanel.stats.changeHealth(localInfo.hp)
	playerPanel.playerMenu.attackMenu.initMenu(localInfo.actionList)
	playerPanel.playerMenu.itemMenu.initMenu(localInfo.itemList)
	playerPanel.playerMenu.miscMenu.initMenu(localInfo.miscList)
	
func attackChosen(attackNum: int):
	localInfo.selectedAction = localInfo.actionList[attackNum]
	return localInfo.selectedAction

func actionChosen(actionNum: int):
	localInfo.selectedAction = localInfo.miscList[actionNum]
	return localInfo.selectedAction

func itemChosen(itemNum: int):
	var item = localInfo.itemList[itemNum]
	localInfo.selectedAction = item.itemAction
	localInfo.itemList.remove_at(itemNum)
	return localInfo.selectedAction

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

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "PlayerDamaged"):
		emit_signal("reactionComplete")
	elif(anim_name == "Death"):
		entityDead()
