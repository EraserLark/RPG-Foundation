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
	
	playerUI.stats.changeHealth(localPlayer.hp)
	playerUI.attackMenu.initMenu(localPlayer.actionList)

func attackChosen(attackNum : int):
	localPlayer.selectedAction = localPlayer.actionList[attackNum]

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

func playerDead():
	battleManager.battleState.eventQueue.currentEvent.battleOver()

func _on_animation_player_animation_finished(anim_name):
	emit_signal("reactionComplete")
