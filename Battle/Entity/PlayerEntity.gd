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
	
	playerActor.player = self
	playerUI.player = self
	
	var attack1 = Attack.new(null, "Basic Attack", self, null, 1, 0)
	var attack2 = Attack.new(null, "Fireball", self, null, 3, 0)
	var attack3 = Attack.new(null, "Uppercut", self, null, 2, 0)
	
	localPlayer.actionList.append(attack1)
	localPlayer.actionList.append(attack2)
	localPlayer.actionList.append(attack3)
	
	playerUI.AttackMenu.initMenu(localPlayer.actionList)

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
	print("You Lose :(")
	emit_signal("playerDied")

func _on_animation_player_animation_finished(anim_name):
	emit_signal("reactionComplete")
