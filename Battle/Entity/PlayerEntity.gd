extends Entity
class_name PlayerEntity

@export var playerInfo : Resource
var playerActor : Node2D
var playerUI : Control
var localPlayer : EntityInfo

signal reactionComplete
signal playerDied

func initialize(bm : BattleManager):
	super(bm)
	playerActor = bm.playerActor
	playerUI = bm.playerUI
	localPlayer = playerInfo
	
	localPlayer.playerEntity = self
	playerActor.player = self
	playerUI.player = self
	
	actor = playerActor
	
	if(localPlayer.actionList.is_empty()):
		localPlayer.setupAttacks(battleManager)
	
	if(localPlayer.itemList.is_empty()):
		localPlayer.setupItems(battleManager)
	
	if(localPlayer.miscList.is_empty()):
		localPlayer.setupMisc(battleManager)
	
	playerUI.stats.changeHealth(localPlayer.hp)
	playerUI.attackMenu.initMenu(localPlayer.actionList)
	playerUI.itemMenu.initMenu(localPlayer.itemList)
	playerUI.miscMenu.initMenu(localPlayer.miscList)
	
func attackChosen(attackNum : int):
	localPlayer.selectedAction = localPlayer.actionList[attackNum]
	return localPlayer.selectedAction

func actionChosen(actionNum : int):
	localPlayer.selectedAction = localPlayer.miscList[actionNum]
	return localPlayer.selectedAction

func itemChosen(itemNum : int):
	var item = localPlayer.itemList[itemNum]
	localPlayer.selectedAction = item.itemAction
	localPlayer.itemList.remove_at(itemNum)
	return localPlayer.selectedAction

func attack():
	pass

func takeDamage(dmg : int):
	var trueDmg = localPlayer.calcDamage(dmg)
	localPlayer.takeDamage(trueDmg)
	
	playerActor.damageAnimation(trueDmg)
	
	var remainingHealth = localPlayer.hp
	playerUI.changeStatsHealth(remainingHealth)
	
	if(remainingHealth <= 0):
		playerDead()

func gainHealth(amt : int):
	localPlayer.addHealth(amt)
	
	var remainingHealth = localPlayer.hp
	playerUI.changeStatsHealth(remainingHealth)
	
	emit_signal("reactionComplete")

func boostDefense(amt : int):
	localPlayer.def += amt

func revertStatus():
	localPlayer.def -= 1

func gainStatus(statusType):
	if(statusType == Status.Type.POISON):
		applyStatus(PoisonStatus, battleManager.statusRoster)
	elif(statusType == Status.Type.DEFUP):
		applyStatus(DefenseStatus, battleManager.statusRoster)
	emit_signal("reactionComplete")

func playerDead():
	battleManager.battleRoster.players.erase(self)
	battleManager.battleState.battleEQ.currentEvent.actionEQ.queue.erase(localPlayer.selectedAction)
	playerActor.queue_free()
	battleManager.battleRoster.checkPlayersAlive()
	emit_signal("reactionComplete")
	queue_free()

func _on_animation_player_animation_finished(_anim_name):
	emit_signal("reactionComplete")
