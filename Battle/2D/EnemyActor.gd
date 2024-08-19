extends BattleActor
class_name BattleActor_Enemy

##Preload vars
var damageNum := preload("res://Battle/2D/PopUpNumber.tscn")

##Children references
@onready var sprite := $Sprite2D
@onready var animPlayer := $AnimationPlayer

##Signals
signal entered
signal enemyDied

func initialize(enemyData: EnemyInfo):
	sprite.texture = enemyData.sprite

func damageFeedback(dmgAmt : int):
	animPlayer.play("SnowbroDamaged")
	var damageNumber := damageNum.instantiate()
	damageNumber.setLabel(dmgAmt)
	add_child(damageNumber)

func attackFeedback():
	animPlayer.play("AttackPlayer")

func enterBattle():
	animPlayer.play("EnterBattle")

func setVisible(case : bool):
	self.setVisible(case)

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "EnterBattle"):
		emit_signal("entered")
