extends BattleActor
class_name BattleActor_Player

##Preload vars
var damageNum:= preload("res://Battle/2D/PopUpNumber.tscn")

##Children references
@onready var animPlayer = $AnimationPlayer
@onready var audioPlayer = $AudioStreamPlayer2D

##Parent references
var battleManager	#Unused
var playerEntity: PlayerEntity
var playerUI: PlayerUI_Battle
var cam: Camera2D

#Create func so that player actor origin is aligned with player menu

func initialize(pe: PlayerEntity, bs: BattleStage):
	playerEntity = pe
	battleManager = playerEntity.battleManager
	playerUI = playerEntity.battleUI
	animPlayer = playerUI.animPlayer
	cam = bs.camera
	
	playerEntity.battleActor = self

func damageFeedback(dmgAmt: int):
	#animPlayer.play("PlayerDamaged")
	playerUI.animPlayer.play("Player_Damaged")
	var damageNumber:= damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)
