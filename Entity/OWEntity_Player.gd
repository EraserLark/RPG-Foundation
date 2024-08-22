extends Entity
class_name OWEntity_Player

var overworldManager: OverworldManager

var entityActor: OW_Player
var entityUI: Control #Not sure OW equivalent for entityUI

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	if(om == null):
		printerr("overworldManager not passed")
		return
	overworldManager = om

func getClassInstance():
	return self

func gainStatus(statusType):
	pass

func applyStatus(statusEffect, statusRoster):
	pass

func boostDefense(amt: int):
	super(amt)

func decreaseDefense(amt: int):
	super(amt)

func revertStatus():
	super()

func gainHealth(amt: int):
	pass

func takeDamage(dmg: int, pierce: bool):
	pass

func checkRoster():
	pass

func entityDead():
	pass
