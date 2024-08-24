extends Entity
class_name OWEntity_Player

var overworldManager: OverworldManager
var dialogueManager:= DialogueManager.new(self)

var entityActor: OW_Player
var entityUI: PlayerUI_World #Not sure OW equivalent for entityUI
var playerNumber: int
var playerState: State

func initialize(om: OverworldManager = null, bm: BattleManager = null):
	if(om == null):
		printerr("overworldManager not passed")
		return
	overworldManager = om
	entityActor = overworldManager.overworldWorld.currentRoom.castList.playerActors[playerNumber]
	entityUI = overworldManager.overworldUI.playerUIRoster[playerNumber]

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
	entityInfo.addHealth(amt)

func fullHeal():
	var maxHP = entityInfo.hpMax
	var currentHP = entityInfo.hp
	entityInfo.addHealth(maxHP - currentHP)

func takeDamage(dmg: int, pierce: bool):
	pass

func checkRoster():
	pass

func entityDead():
	pass
