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
	
	if(localPlayer.actionList.is_empty()):
		localPlayer.setupAttacks()
	
	if(localPlayer.itemList.is_empty()):
		localPlayer.setupItems()
	
	if(localPlayer.miscList.is_empty()):
		localPlayer.setupMisc()
	
	playerUI.stats.changeHealth(localPlayer.hp)
	playerUI.attackMenu.initMenu(localPlayer.actionList)
	playerUI.itemMenu.initMenu(localPlayer.itemList)
	playerUI.miscMenu.initMenu(localPlayer.miscList)
	
func attackChosen(attackNum : int):
	localPlayer.selectedAction = localPlayer.actionList[attackNum]

func actionChosen(actionNum : int):
	localPlayer.selectedAction = localPlayer.miscList[actionNum]

func itemChosen(itemNum : int):
	var item = localPlayer.itemList[itemNum]
	localPlayer.selectedAction = item.itemAction
	localPlayer.itemList.remove_at(itemNum)

func attack():
	pass

func takeDamage(dmg : int):
	var trueDmg = localPlayer.calcDamage(dmg)
	localPlayer.takeDamage(trueDmg)
	
	playerActor.damageAnimation()
	
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

func gainStatus(statusName : String):
	if(statusName == "Poison"):
		battleManager.createStatus(PoisonStatus, self)
	elif(statusName == "Defend"):
		battleManager.createStatus(DefenseStatus, self)
	emit_signal("reactionComplete")

func playerDead():
	battleManager.battleState.battleEQ.currentEvent.battleOver()

func _on_animation_player_animation_finished(_anim_name):
	emit_signal("reactionComplete")
