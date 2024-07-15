extends Entity
class_name PlayerEntity

#@export var playerInfo : Resource
#var playerActor : Node2D
var playerUI : Control
#var localInfo : EntityInfo

signal playerDied

func initialize(bm : BattleManager):
	super(bm)
	
	actor = bm.playerActor
	playerUI = bm.playerUI
	
	localInfo.playerEntity = self
	actor.player = self
	playerUI.player = self
	
	if(localInfo.actionList.is_empty()):
		localInfo.setupAttacks(battleManager)
	
	if(localInfo.itemList.is_empty()):
		localInfo.setupItems(battleManager)
	
	if(localInfo.miscList.is_empty()):
		localInfo.setupMisc(battleManager)
	
	playerUI.stats.changeHealth(localInfo.hp)
	playerUI.attackMenu.initMenu(localInfo.actionList)
	playerUI.itemMenu.initMenu(localInfo.itemList)
	playerUI.miscMenu.initMenu(localInfo.miscList)
	
func attackChosen(attackNum : int):
	localInfo.selectedAction = localInfo.actionList[attackNum]
	return localInfo.selectedAction

func actionChosen(actionNum : int):
	localInfo.selectedAction = localInfo.miscList[actionNum]
	return localInfo.selectedAction

func itemChosen(itemNum : int):
	var item = localInfo.itemList[itemNum]
	localInfo.selectedAction = item.itemAction
	localInfo.itemList.remove_at(itemNum)
	return localInfo.selectedAction

func attack():
	pass

func takeDamage(dmg : int):
	super(dmg)

func gainHealth(amt : int):
	super(amt)

func updateUI(hp : int):
	playerUI.changeStatsHealth(hp)

#
#func boostDefense(amt : int):
	#localInfo.def += amt
#
#func revertStatus():
	#localInfo.def -= 1

#func gainStatus(statusType):
	#if(statusType == Status.Type.POISON):
		#applyStatus(PoisonStatus, battleManager.statusRoster)
	#elif(statusType == Status.Type.DEFUP):
		#applyStatus(DefenseStatus, battleManager.statusRoster)
	#emit_signal("reactionComplete")

func entityDead():
	battleManager.battleRoster.players.erase(self)
	battleManager.battleRoster.checkPlayersAlive()
	super()

func _on_animation_player_animation_finished(_anim_name):
	emit_signal("reactionComplete")
