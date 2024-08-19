extends Event
class_name EnemyEnter

var enemies : Array[EnemyEntity]
var entered : int

func _init(eManager, e):
	super(eManager)
	enemies = e

func runEvent():
	for enemy in enemies:
		enemy.actor.entered.connect(enemyEntered)
		enemy.actor.enterBattle()

func enemyEntered():
	entered += 1
	
	if(entered >= enemies.size()):
		finishEvent()

func finishEvent():
	super()
