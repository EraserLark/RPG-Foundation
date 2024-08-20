extends BattleActor
class_name BattleActor_Player

##Preload vars
var damageNum:= preload("res://Battle/2D/PopUpNumber.tscn")

##Children references
@onready var animPlayer = $AnimationPlayer
@onready var audioPlayer = $AudioStreamPlayer2D

##Parent references
var battleManager	#Unused
var player			#Unused
var playerUI: PlayerUI_Battle
var cam: Camera2D

#Create func so that player actor origin is aligned with player menu

func initialize(bm: BattleManager, bs: BattleStage, num:int):
	battleManager = bm
	playerUI = bm.playerEntities[num].playerUI
	cam = bs.camera

func damageFeedback(dmgAmt: int):
	#animPlayer.play("PlayerDamaged")
	playerUI.animPlayer.play("Player_Damaged")
	var damageNumber:= damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
