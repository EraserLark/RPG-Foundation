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
	
	#var item = Item_Heal.new()
	#var itemArray : Array[Item] = [item]
	#if(localPlayer.itemList.is_empty()):
		#localPlayer.setupItems(itemArray)
	
	playerUI.stats.changeHealth(localPlayer.hp)
	playerUI.attackMenu.initMenu(localPlayer.actionList)
	playerUI.itemMenu.initMenu(localPlayer.itemList)

func attackChosen(attackNum : int):
	localPlayer.selectedAction = localPlayer.actionList[attackNum]

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

func playerDead():
	battleManager.battleState.eventQueue.currentEvent.battleOver()

func _on_animation_player_animation_finished(anim_name):
	emit_signal("reactionComplete")
