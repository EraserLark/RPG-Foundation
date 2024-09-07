extends Node
class_name Entity

var entityInfo: Resource #EntityInfo?

signal reactionComplete

func initialize(sm: StageManager = null):
	pass

func getClassInstance():
	return self

func gainStatus(statusType):
	pass

func applyStatus(statusEffect, statusRoster):
	pass

func boostDefense(amt: int):
	entityInfo.def += amt

func decreaseDefense(amt: int):
	entityInfo.def -= amt

func revertStatus():
	entityInfo.def -= 1

func gainHealth(amt: int):
	pass

func fullHeal():
	pass

func takeDamage(dmg: int, pierce: bool):
	pass

func attack():
	pass

func entityDead():
	pass

func checkRoster():
	pass
